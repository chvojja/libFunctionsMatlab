
% Definice
% wkj .mat =  soubor ktery je citelny prohlizeckou Kudlajda Viewer
% .h5 = soubor ktery vypadne z nahravani pres wavesurfer na 2p mmikroskopu

% \\neurodata3\Lab Neuro Optophys\Ca imaging\Monika 2p
% \\neurodata2\Large data\Monika 2p\VIP_tdT
% \\neurodata2\Large data\Monika 2p\VIP_tdT WT mTOR

% Popis funkce
% 1. vyhleda vsechny .h5 spubory v pripojenem disku Monika 2p (u ni na kompu A:\)
% 2. zjisti, ke kteremu .h5 souboru jiz existuje wkj .mat soubor
% 3. POkud takovy soubor neexistuje, vytvori ho:
%   1. nacte ho pomoci loadH5ondrej()
%   2. zfiltruje oba kanaly na FR HFOcka 
%   3. ulozi kanaly v poradi 'L' = leze 'L_hp' - leze filtrovana 
%      'C' = kontra 'C_hp' = kontra filtrovana


% path_root = 'A:\';
% %path_root = 'V:\Monika 2p\VIP_tdT\534 M\2p 20210915 ET534 F9 ptz';
% path_root = 'V:\Monika 2p\VIP_tdT';

h52wkj('A:\VIP_tdT');
h52wkj('A:\VIP_tdT WT mTOR');
h52wkj('E:\Ca imaging\Monika 2p');


function h52wkj(path_root)
    
dirContents_h5=dir([path_root '\**\*.h5']);
dirContents_wkj=dir([path_root '\**\*.mat']);

ffh5=fullfile({dirContents_h5(:).folder},{dirContents_h5(:).name});
ffwkj=fullfile({dirContents_wkj(:).folder},{dirContents_wkj(:).name});


%dirContents_wkj(~contains({dirContents_wkj.name},'.h5-'),:)=[]; %pro vymazani souboru

Nh5=size(dirContents_h5,1);
Nwkj=size(dirContents_wkj,1);

% pro vymazani souboru
% for kf = 1:Nwkj
%     delete(fullfile(dirContents_wkj(kf).folder,dirContents_wkj(kf).name));
% end



disp(['Found ' num2str(Nh5) ' h5 files and '  num2str(Nwkj) ' wkj files.']);
written = 0;
for kf = 1:Nh5
    %kf =2154
    nemameKudlajziVerzi = ~any(contains(ffwkj, ffh5{kf}));

    if nemameKudlajziVerzi
        % pokud nemame, tak ji vytvorime
        
        try
            % 
            ffh5{kf}
            lf = loadH5ondrej(ffh5{kf},1000);
            df=dir(ffh5{kf});
            dateN=df.datenum;
        catch ME
            disp(['monco, soubor: ' ffh5{kf} ' nejde nacist, asi je to rozbity.']);
            continue;
        end

        %xCols = lf(:,[1 2]);
        xCols = lf(:,:); % oprava aby tam byl videt i ten dummy kanal
        %% filtrace 
        Fstops = [250 300 1000 1050];  % F2 a F3 jsou tz hlavni
	    Fs = 20000;
        Dstop = 0.001;          % Stopband Attenuation - utlum 60 db/dec
        Dpass = 0.17099735734;  % Passband Ripple
        dens  = 20;             % Density Factor
        [N, Fo, Ao, W] = firpmord(Fstops/(Fs/2), [0 1 0], [ Dstop, Dpass, Dstop]);
        b  = firpm(N, Fo, Ao, W, {dens});
        %freqz(b,1)
        xColsF=filtfilt(b,1,xCols);
        xCols = [xCols xColsF];
        
        Ncols = size(xCols,2);  % ted je zprehazime normalni filtrovanz normalni filtrovany...
        indexvector  = reshape(reshape([1:Ncols],Ncols/2,2)',1,Ncols);
        s = xCols(:,indexvector)';   
%         endout=regexp(ffh5{kf},'\','split');
%         subjName = join(endout(2:end),'______');
%         subjName= subjName{1};

        subjName = dirContents_h5(kf).name;
  
        WKJcontent = getOneWKJcontent(s,subjName,dateN);
  
        path = dirContents_h5(kf).folder;
        saveWKJcontent(WKJcontent,path,0)
        written = written +1;
       
    end
    
end
disp(['finished, written ' num2str(written) ' files.']);
end

function WKJcontent = getOneWKJcontent(s,subjName,dateN)
    
    WKJcontent=struct;
    WKJcontent.s=s;
    WKJcontent.N=size(WKJcontent.s,2);
    WKJcontent.subject = subjName;
    WKJcontent.fs = 20000;

    WKJcontent.dateN=dateN;
    WKJcontent.dateStr=datestr(WKJcontent.dateN);
    WKJcontent.units = 'mV';
    WKJcontent.recStation = '2P';
    WKJcontent.nCh=size(WKJcontent.s,1);
    switch WKJcontent.nCh
        case 4
            WKJcontent.chanNames = {'L','L_hp','C','C_hp'};
        case 6
            WKJcontent.chanNames = {'L','L_hp','C','C_hp','Dummy','Dummy_hp'};
        otherwise
            WKJcontent.chanNames = arrayfun(@num2str, 1:WKJcontent.nCh, 'UniformOutput', 0);
    end
      
    
end

function saveWKJcontent(WKJcontent,path,kF)
     wkj_fname = [WKJcontent.subject '-' datestr(WKJcontent.dateN,'yymmdd_HHMMSS') '-' WKJcontent.recStation '-' num2str(WKJcontent.fs) 'HZ' '-' num2str(kF,'%03d') '.mat'];
     %[status, msg, msgID] = mkdir(path);
     save([path  '\' wkj_fname],'-struct','WKJcontent','-v7');% save data
     disp(['saving file: ' path  '\' wkj_fname]);
end

    
