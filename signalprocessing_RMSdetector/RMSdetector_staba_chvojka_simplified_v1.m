function det_struct = RMSdetector_staba_chvojka_simplified_v1(s,fs,filteringfun, n_std_rms, freq_bounds , rmsLen_ms, join_gap_ms, minAcceptLen_ms, minPeaks, peakPromRatio, Nover, b_disp)
arguments 
    s; % input signal
    fs; % sampling freq
    filteringfun;
    n_std_rms = 3; % kind of sensitivity

    % optional
    freq_bounds = [];
    rmsLen_ms = 3;
    join_gap_ms = [];
    minAcceptLen_ms = [];
    minPeaks = 8; % number of oscillations
    peakPromRatio = []; %0.25; % oscillatorines
    Nover = 20; % default xcorr oversampling
    b_disp = false;
end

s=s(:); % make sure s is column
if ~isempty(freq_bounds)
    f_max = freq_bounds(2);
    f_min=freq_bounds(1);
end

%% filtrace 

fd = filteringfun(s);


%%
rms_length=round(rmsLen_ms*10^-3*fs); % delka segmentu = 3ms ze ktere se pocita rms
rms_fd=zeros(size(fd));


seg_down=floor((rms_length-1)/2);
seg_up=ceil((rms_length-1)/2);
for i=1:size(s,1)
    seg_start=i-seg_down; %nastaveni zacatku segmentu
    seg_end=i+seg_up; %nastaveni konce segmentu
    if seg_start<1 %korekce u zacatku signalu
        seg_start=1;
    end
    if seg_end>size(s,1) %korekce u konce signalu
        seg_end=size(s,1);
    end
    rms_fd(i,:)=sqrt(  mean(fd(seg_start:seg_end,:).^2));   % rms value of filtred signal fd of the size rms_length 
end
   
%% prahovani
mean_rms_fd=mean(rms_fd); % mean rms of the whole filtered signal
std_rms_fd=std(rms_fd); % mean std of the whole filtered signal

threshold_rms_fd=repmat((mean_rms_fd+n_std_rms*std_rms_fd),size(fd,1),1);
hfo_cand=rms_fd>threshold_rms_fd; % boolean of samples , HFO candidtes

%% kontrola delky, kratke se vyhodi, blizke spoji
join_gap_samples=round(join_gap_ms*10^-3*fs); % gap in indexes
minAcceptLen_samples=round(minAcceptLen_ms*10^-3*fs); % min len in indexes

hfo_cand(1)=0;
hfo_cand(end)=0;

hfo_open=imopen(hfo_cand,strel('line',round(fs/f_max),90)); % remove shorter than 1 period of fmax
hfo_close=imclose(hfo_open,strel('line',join_gap_samples,90)); % join closer than join_gap
hfo_close=imopen(hfo_close,strel('line',minAcceptLen_samples,90)); % remove shorter than minAcceptLen

% hold on;
% plot(fd);
% plot(rms_fd);
% plot(vector_threshold)
% plot(s);
% plot(0.1*hfo_cand)
% plot(0.1*hfo_close)
% disp('')
% close(gcf); 
   
% v hfo_close jsou všechny nad trhresholdem, s minlength a spojeny vedlejsi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subplot(2,1,1);
% hold on;
% plot(0.4*hfo_close,'k');
% plot(rms_fd,'r')
% plot(fd,'b')
% plot(vector_threshold,'k')
% if sum(hfo_cand)~=0
% nonzerohfoc=find(hfo_cand);
% tt=zeros(size(fd)); tt(nonzerohfoc(1):nonzerohfoc(1)+minAcceptLen)=max(fd);
% plot(tt,'g');
% end
% subplot(2,1,2);
% plot(s);
% close(gcf);


if ~isempty(hfo_close)

%% 
% abs_fd=abs(fd);
% m_abs_fd=mean( abs_fd ); % rectified filtered
% s_abs_fd=std( abs_fd );
%  % pocet vrcholku ktere maji byt vyssi jak ntimes std
% vector_threshold2=repmat((m_abs_fd+n_std_peak*s_abs_fd),size(fd,1),1);

%% Measuring frequency

% onset_offsets=get_OOI(double(hfo_close));
[ detections_len , onsetsInd, offsetsInd ] = s2intervals( double(hfo_close) );
onset_offsets = [ onsetsInd offsetsInd  ];

count_detections=numel( onsetsInd );
hfo_freqs=zeros(1,count_detections);
passedInds = true(count_detections,1);
peaksIndsC=cell(count_detections,1); %false(count_OOI,length(fd));
figdataC=cell(count_detections,1);

failedOnC=cell(count_detections,1); % debugging info
diagC=cell(count_detections,1); % debugging info




for i=1:count_detections
    start=onset_offsets(i,1); stop=onset_offsets(i,2);
    
    % start autocorelation freq detection
    xOver=fd(start:stop);
    xOver=xOver-mean(xOver); 

    % we oversample fs
    xOver = interpft(xOver,Nover*numel(xOver));
    fsOver = Nover*fs;
    
    if ~isempty(freq_bounds)
        [fp,fi,~,p]=findpeaks(xcorr(xOver,xOver),'SortStr','descend','MinPeakDistance', round(fsOver/f_max) ); %,'MinPeakWidth',widthSec);
    else
        [fp,fi,~,p]=findpeaks(xcorr(xOver,xOver),'SortStr','descend'); %
    end
    [fi_linear,I] = sort(fi,'ascend');
    fp_linear = fp(I);
    p_linear = p(I);
    fi_linear_middleInd = floor(numel(fi)/2)+1; % index of 

    % ultimate condition
    if numel(fp)>3
        % conditions
        if numel(fp)<minPeaks  % if test number of peaks
           passedInds(i)=false; % this HFO failed
           failedOnC{i} = [ failedOnC{i} '   '  'minPeaks ' num2str(numel(fp)) ' expected: ' num2str(max(minPeaks,2))];
        end
        diagC{i} = [ diagC{i} '   '  'minPeaks ' num2str(numel(fp)) ' expected: ' num2str(max(minPeaks,2))];
    
        if ~isempty( peakPromRatio ) % if test prominance
           prominanceSecondVsFirst=p_linear( fi_linear_middleInd+1 ) /p(1);
           if prominanceSecondVsFirst<peakPromRatio
              passedInds(i)=false; % this HFO failed
              failedOnC{i} = [ failedOnC{i} '   '  'peakPromRatio ' num2str(prominanceSecondVsFirst) ' expected: ' num2str(peakPromRatio) ];
           else
               diagC{i} = [ diagC{i} '   '  'peakPromRatio ' num2str(prominanceSecondVsFirst) ' expected: ' num2str(peakPromRatio) ];
           end 
        end
        
        % measure freq
        hfo_freqs(i) = fsOver/min(abs(fi(2:end)-fi(1)));
        if ~isempty(freq_bounds)
            if hfo_freqs(i)<f_min || hfo_freqs(i)>f_max
               passedInds(i)=false; % this HFO failed
               failedOnC{i} = [ failedOnC{i} '   '  'f bounds ' num2str( hfo_freqs(i) ) ];
            else
                diagC{i} = [ diagC{i} '   '  'f bounds ' num2str( hfo_freqs(i) ) ];
            end
        end
    
       
       % record oscillation peaks
       peaksIndsC{i} = [  start + round(fi_linear(1:fi_linear_middleInd)/Nover)   ];
    else
       passedInds(i)=false; % this HFO failed
    end


 % Visualization
 if b_disp %%&& selectedIDx(i)

    % plot all or only hfos that passed
    if passedInds(i)
        b_plotit=true;
    else
        b_plotit=false;
    end
    %b_plotit=true;

    if b_plotit
%%
%  for paper plotting
plot_detection_algo(s,fs,hfo_close,hfo_cand,fd,rms_fd,threshold_rms_fd,xOver,fsOver);

%%

    figurefull;
    subplot(3,1,1);
    hold on;
    plot(0.4*hfo_close,'g');
    plot(0.2*hfo_cand,'k');
    plot(rms_fd,'r')
    plot(fd,'b')
    plot(threshold_rms_fd,'k')
    dd=zeros(size(threshold_rms_fd,1),1);
    dd(start:stop)=0.4;
    %plot(dd,'y')
    
    subplot(3,1,2);
    plot(s);
    
    subplot(3,1,3)
    findpeaks(xcorr(xOver,xOver),'SortStr','descend','MinPeakDistance', round(fsOver/f_max) )
    %plotstockwell(s,fs,1.8,[300 800],10,'linear')
    





%findpeaks(xcorr(xOver,xOver),'SortStr','descend','MinPeakDistance', round(fsOver/f_max) )


    figurefull;
    subplot(3,1,1);
    hold on;
    plot(0.4*hfo_close,'g');
    plot(0.2*hfo_cand,'k');
    plot(rms_fd,'r')
    plot(fd,'b')
    plot(threshold_rms_fd,'k')
    dd=zeros(size(threshold_rms_fd,1),1);
    dd(start:stop)=0.4;
    %plot(dd,'y')
    
    subplot(3,1,2);
    plot(s);
    
    subplot(3,1,3)
    findpeaks(xcorr(xOver,xOver),'SortStr','descend','MinPeakDistance', round(fsOver/f_max) )
    %plotstockwell(s,fs,1.8,[300 800],10,'linear')
    
    title( { [  'accepted: ' num2str( passedInds(i) )  '   freq '  num2str(hfo_freqs(i))  '   ' failedOnC{i}]  ,  diagC{i} });



    pause

    % save figure;
    fig_frame=getframe(gcf);
    figdataC{i}=fig_frame.cdata;
    close(gcf); 

    end

    





%     hf=figure;
%     subplot(2,1,1)
%     hold on;
%     off=0;
%     nstr=start-off; nstp=stop+off;
%     if nstr<0, nstr=1; end;
%     if nstp>numel(rms_fd), nstp=numel(rms_fd); end;
%     ncrop=nstp-nstr+1;
%     t=0:1/fs:(ncrop-1)/fs; 
%     plot(t,rms_fd(nstr:nstp),'b'); 
%     plot(t,0.4*hfo_close(nstr:nstp),'k');
%     plot(t,fd(nstr:nstp),'r');
%     plot(t,s(nstr:nstp),'g')
%     plot(t,vector_threshold(nstr:nstp),'k')
%     title(num2str(hfo_freqs(i)))
%     xlabel('time')
%     ylabel('amplitude')
%     title(num2str(selectedIDx(i)));
%     set(gca,'Color','white')
%     hold off;
%     subplot(2,1,2);
%     plot(t,s(nstr:nstp),'k');
    
 


 else % no fig ata
     figdataC{i}=[];
 end


end


det_struct=struct;

% related to individual detections
det_struct.onset_offsets = onset_offsets(passedInds,:); % save detections in onset offset format
det_struct.detections_len = detections_len(passedInds,:);
det_struct.peaksIndsC = peaksIndsC(passedInds,:);
det_struct.hfo_freqs=hfo_freqs(passedInds); % save frequency
det_struct.figdataC = figdataC(passedInds);

% related to the whole signal
det_struct.count_detections = numel(find(passedInds));
det_struct.fd=fd; % save filtered signal
det_struct.rms_fd=rms_fd; %save rms of filtered


else % no output
    det_struct = [];
end





