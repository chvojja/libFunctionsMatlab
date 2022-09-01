classdef signalProvider
    %SIGNALPROVIDER 
    % Assumtions
    % FileTables is a cell array of tables, each with the following format:
    % T = StartDn | FilePath  % we expect the table is sorted ascending in time
    % Fs is samplin frequency for each table
    % LoadFun is a function handle that can load a file at FilePath and return raw signal in columns s and channal labels ChanNames
    %
    % CmdWinTool('isBusy'); to determine if Matlab is busy
    
    properties
        % this is subindexed by fs:
        FilePaths;
        StartDns;
        Files=struct;
        filesLoadedL; % logicals to determine if files are loaded or not

        Nf; % number of files
        NsPerFile; % number of samples (typical) per file
        NsPerFileH; % historical file sizes
        Nfs; % number of sampling freqs

        %
        SamplingFrequencies;
        FsFields;
        LoadFun;
        RangeDn;
        
    end
    
    methods
        function obj = signalProvider(nv)
                arguments
                    % user can provide either this
                    nv.FileTables=[];
                    % or this
                    nv.FileTable=[];

                    % or these two
                    nv.StartDns=[];
                    nv.FilePaths = [];

                    nv.Fs;
                    nv.LoadFun;
                end
                   
                % validation of FileTables

                % save FileTables
                if ~isempty(nv.FileTables)
                        for i = 1: numel(nv.FileTables)
                            fsField = ['fs' num2str(nv.Fs{i})]; obj.FsFields{end+1}=fsField;
                            obj.FilePaths.(fsField) = nv.FileTables{i}.FilePath;
                            obj.StartDns.(fsField) = nv.FileTables{i}.StartDn;
                            obj.Nf.(fsField) = size(nv.FileTables{i}.FilePath,1);
                        end
                end

                if ~isempty(nv.FileTable)
                        fsField = ['fs' num2str(nv.Fs)]; obj.FsFields{end+1}=fsField;
                        obj.FilePaths.(fsField) = nv.FileTable.FilePath;  
                        obj.StartDns.(fsField) = nv.FileTable.StartDn;
                        obj.Nf.(fsField) = size(nv.FileTable.FilePath,1);
                end
                


                % For each Fs
                obj.Nfs = numel(obj.FsFields);
                for i = 1:obj.Nfs
                    % sort it if not sorted
                    fsField = obj.FsFields{i};
                    [obj.StartDns.(fsField),sortedI]=sort(obj.StartDns.(fsField),'ascend');
                    obj.FilePaths.(fsField) = obj.FilePaths.(fsField)(sortedI);  
                    % Initialize Files
                    obj.Files.(fsField) = cell(obj.Nf.(fsField),1);
                    obj.filesLoadedL.(fsField) = false(obj.Nf.(fsField),1);
                end
                obj.LoadFun = nv.LoadFun;
        end


        
        function [s,ChNames] = getByFsDatenum(obj,nv)
            arguments
                obj;
                nv.Fs;
                nv.RangeDn;
            end

              nv.RangeDn=nv.RangeDn(:)';

            fsField = ['fs' num2str(nv.Fs)];
            fStartDn_sorted = obj.StartDns.(fsField);

            % 1nd variant, compare speed
            % get start/end index of file in sorted files
%         
%             startI_insorted=0; endI_insorted=0;
% 
%             for i=1:numel(fStartDn_sorted)
%                 if (fStartDn_sorted(i)<= nv.RangeDn(1) )
%                     startI_insorted=i;
%                 end
%                 if (fStartDn_sorted(i)< nv.RangeDn(2)  )
%                     endI_insorted=i;
%                 end
%             end
%             toLoadFilesI=startI_insorted:endI_insorted;


            % 2nd variant, compare speed
            startL =  fStartDn_sorted <= nv.RangeDn(1); 
            endL =  fStartDn_sorted < nv.RangeDn(2);
            startL=[startL(2:end) false];
            toLoadFilesL = endL-startL;


            % Load the files that we dont have cached:
            noNeedToLoadFromToLoadL = obj.filesLoadedL & toLoadFilesL;
            toLoadFilesL = ~noNeedToLoadFromToLoadL & toLoadFilesL;


         [ii,toLoadFilesI] = find(toLoadFilesL);
        for i = toLoadFilesI
            obj.Files{i} = load(  obj.FilePaths.(fsField){i}   );
            obj.filesLoadedL(i) = true;
        end

        disp('')

%         Ns=round(dn2sec(requestedEndDn-requestedStartDn)*d.fs); % number of samples
%         y.time=linspace(requestedStartDn,requestedEndDn,Ns)';
%         y.fs=d.fs;
%         y.sourceFiles = fpathname;
%         
%         Nch=numel(d.kchs);
%         y.data=zeros(Ns,Nch);
%         
%         
%         % fpath = [rootWKJ, '\' subjName '\'  WKJfs2foldername(fs)];
%         % fpathname = ls2cell(fpath);
%         Nf = numel(fpathname);
%         
%         % get EEG from all files
%         for kf = 1:Nf   
%            %[fpat, fnam, exte] = fileparts(fpathname);
%             lf=load([d.rootWKJ, '\' d.subjName '\' num2str(d.fs) 'HZ\' fpathname{kf}]);
%             % ted to musim oøíznout
%             % pozor dá se to zoptimalizovat
%             dataStartDn=lf.dateN;
%             %if requestedStartDn<lf.dateN, dataStartDn=lf.dateN; end
%             N=size(lf.s,2);
%             iv = sedn2ivf(requestedStartDn,requestedEndDn,dataStartDn,N,d.fs); % oøez v rámci fajlu
%             data = lf.s(d.kchs,iv)'; % toto je nový formát WKJ co kanál to sloupec
%             if kf == 1, dataStartDn=requestedStartDn; end
%             iv = dn2indexVectorOfFrame(dataStartDn,size(data,1),requestedStartDn,Ns,d.fs); % where inside the requested frame to put the data
%             y.data(iv,1:Nch)=data; % add data one channel after another as columns
%         end
%         



        end




    end
end

