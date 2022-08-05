classdef WKJiterateSubjectLabelChanelDetectionObj < WKJiterateSubjectObj
   properties
       %settings
       fs; % which fs to load based on label
       kchs; % for choosing what channels of eeg to load based on label or which kch to iterate
       detNames; % which detNames of label file to read /cellarray
       detFolder; % what is the name of label folder
       
      % changing in for loops: 
      % Kudlajz WKJ label file
      lblFileIDx;
      lblStartDn;
      lblStartDnFirstFile;
      lblFileName;
      lblFileContent;
      Nlblfiles
      limitLblFiles; %
      
      % channel
      chStruct; % temp structure for Channel
      kch;
      chName; % string 
      
      
      % detection
      detName;  % current detection name in label
      
      detStartDn;
      detEndDn;
      detDurDn;
      detIDx; % pointer to detection
      detValue;
      
      % not necessary changing, but additional info
      chNames;
      Nch;
      temp_initCh
      
      % channel stats
      chStats
   end 



 methods
     
    function o = WKJiterateSubjectLabelChanelDetectionObj(varargin)  % for initializing object
        o@WKJiterateSubjectObj(varargin{1});
        %o@WKJiterateSubjectLabelChanelDetectionObj(arg);
         if ~isempty(varargin)
             
             initObj  = varargin{1};
             mco = ?WKJiterateSubjectLabelChanelDetectionObj;
             for prop = mco.PropertyList'
                if ismember(prop.SetAccess, {'public', 'protected'}) && ( isfield(initObj,prop.Name) | isprop(initObj,prop.Name) )
                   o.(prop.Name) = initObj.(prop.Name);
                else
                   warning('could not copy property %s', prop.Name);
                end
             end   
         end
    end
    
    function iterateWKJLabel(o)
    o.temp_initCh.(o.subjName)=[]; % init temp channel
    % to handle empty label foldername
    if isempty(o.detFolder)
        dr=dirdir([o.rootWKJ, '\' o.subjName '\'],'Label|LABEL|label|Labels|labels|LABELS');
        detFolder = dr.name;
    else
        detFolder = o.detFolder;
    end
    % getting labels
    flblpath = [o.rootWKJ, '\' o.subjName '\'  detFolder];
    flblNames = ls2cell(flblpath);
    
    if ~isempty(o.limitLblFiles) % limit files
        Nlblfiles = min(o.limitLblFiles,numel(flblNames));
    else % do all files found
        Nlblfiles = numel(flblNames);
    end
    	
    o.Nlblfiles=Nlblfiles;
    
    for kf = 1:Nlblfiles
        lblFileName = flblNames{kf};
        o.lblFileContent=load([flblpath '\' lblFileName]);

        o.lblFileIDx=kf;
        o.lblStartDn = fnam2dn(flblNames{kf});
        o.lblFileName=flblNames{kf};
        
        Ndet=numel(o.detNames); % choose particular detection names
        for kDet=1:Ndet
            o.detName=o.detNames{kDet};
            onLabelNextDetName(o);
            onNextDetName(o);
            if isfield(o.lblFileContent.label,o.detName)
                chNames = o.lblFileContent.label.(o.detName).chanNames; 
                o.chNames=chNames;
                Nch=numel(chNames);
                o.Nch=Nch;
                
                
                if kf==1 % first label file start
                    o.lblStartDnFirstFile=o.lblStartDn; 
                    onLabelFirstFile(o);
                    
                end
                        

                
                onLabelNextFile(o); % beware! this is launched for every detectionName!!!
                if o.verboseOn, disp(['I have just loaded a file. ']); end;

                for kch = o.kchs
                    if isfield(o.lblFileContent.label.(o.detName),(num2kch(kch)))
                        o.chStruct = o.lblFileContent.label.(o.detName).(num2kch(kch));
                        o.kch = kch;
                        o.chName = o.chNames{kch};
                        
                        if ~isempty(o.chStruct)
                            if o.verboseOn, disp(['Im in a subject channel: ' o.subjName ' channel: '  num2str(o.kch)]); end;
                            if ~isfield(o.temp_initCh.(o.subjName),o.chName)
                                o.temp_initCh.(o.subjName).(o.chName)=true;
                                onLabelInitChannel(o);
                            end
                            onLabelNextChannel(o);
                            for i = 1:numel(o.chStruct.posN)  
                                o.detStartDn = o.chStruct.posN(i);
                                o.detEndDn = o.chStruct.posN(i) + o.chStruct.durN(i);
                                o.detDurDn = o.chStruct.durN(i);
                                o.detIDx = i;
                                o.detValue = o.chStruct.value(i);
                                if o.verboseOn, disp(['Im a detection: '  num2str(o.detIDx)]); end;
                                onLabelNextDetection(o); 
                            end
                        end
                      onLabelFinishedChannel(o);   
                    end
                end
                onLabelFinishedFile(o);
            else
                % isfield
                % try different detName
            end
        end
    end
    end
    
    
   function iterateChStats(o)
        Ndet=numel(o.detNames); % choose particular detection names
        for kDet=1:Ndet
            o.detName=o.detNames{kDet};
            onNextDetName(o);
                for kch = o.kchs
                        o.kch = kch;
                        o.chName = o.chNames{kch};
                         if o.verboseOn, disp(['Im in a subject channel: ' o.subjName ' channel: '  num2str(o.kch)]); end;
                        
                         o.chStats=o.st.(o.subjName).(o.detName).(o.chName); % for reading
                         onChStatsNextChannel(o);
                end
                onChStatsFinishedDetName(o);
        end % end det
   end
   
   function chStatsSaveFigure(o,name)
       disp('saving');
       set(gcf,'color','white');
       %scr_siz = get(0,'ScreenSize') ;
       size = [ 200 100 1024 768];
       %figPos = floor([scr_siz(3)/2 scr_siz(4)/2 scr_siz(3)/2 scr_siz(4)/2]) ;
       set(gcf, 'Position',  size);
       
       figname =[name '_'  o.detName];
       
       mkdir([o.subjPath '\outputFigures\']);
       figFPath = [o.subjPath '\outputFigures\' figname '.fig'];
       savefig(gcf,figFPath);

       pngFPath = [o.subjPath '\outputFigures\' figname '.png'];    
       saveas(gcf,pngFPath);
       close(gcf);  
   end
   
   
   
   
   
   function onChStatsFinishedDetName(o)
       
   end
%    
%    function setChStats(o,stats)
%        o.st.(o.subjName).(o.detName).(o.chName) = stats;
%    end
   
    function onChStatsNextChannel(o)
        % only on first file

    end
   
    
    function onLabelFirstFile(o)
        % only on first file

    end
    
    function onLabelNextFile(o)
        % on every new label file loaded

    end
    
    function onLabelNextDetName(o)
        % only on first file

    end
    function onNextDetName(o)
        % only on first file

    end
    
    
    function onLabelFinishedFile(o)
        % on new label file finished

    end
    
    function onLabelFinishedChannel(o)
        % on channel finished

    end
    
    function onLabelNextChannel(o)
        % now there is a current o.chStruct
        % user code
    end
    
    function onLabelInitChannel(o)
        % this runs only first time the channel has been opened typicaly in
        % the first file of the animal when there is something in the
        % channel field.
        % user code
    end

    function onLabelNextDetection(o) 
        % now there is a current detection in d.lblStartDn,d.labelEndDn
        
    end
    
 end
end