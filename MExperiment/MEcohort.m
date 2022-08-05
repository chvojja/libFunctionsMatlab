classdef MEcohort < Verboser
    % MExperiment Summary of this class goes here
    %   Object holds information about a experimental subject
    
    properties
%         name % nam e of the cohort
%         verbose = true; % defualt behavior

        Tsub; % table of the subjects
        Tdat; % table of the data to each mice
        Tdati; % table of the data with info about data dir
%         Tvkj; % VKJ related informations
%         Teeg; % eeg related informations

        N_subj
        N_subjInGroupCTRL
        N_subjInGroupTREAT
        N_Trows = 100; % default number of rows

     

    end
    
    methods
        % constructor
        function o = MEcohort(nv_verb,nv)      
            arguments
                nv_verb.Name ='DefaultCohort'; % these parameters are ment to be passed to Verboser object
                nv_verb.Verbose;

                nv.Additional = 'sdsd';
            end
            % Take care of Verboser constructor
            nv_verbC = namedargs2cell(nv_verb);
            o = o@Verboser(nv_verbC{:});
            defineMessages(o); 

            o.Tsub = table_createEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','Treatment','cat','Role','cat'); % one row per subject    
            o.Tdat = table_createEmpty(o.N_Trows,'ID','double','Subject','cat','Format','cat','Treatment','cat','RootDir','cat','Folder','cat','Scanned','logical'); % one row per data folder
            o.Tdati = table_createEmpty(o.N_Trows,'ID','double','Subject','cat','SingleSubject','logical','Files','double','StartDate','char','EndDate','char','TimeSpanDays','double','TimeRawDays','double','MinsPerFile','double','MissingFiles','logical'); % one row per data folder
%             o.T.eeg = table_createEmpty(o.N_Trows,'Fs','double','Channels','cell','CountCh','double');
            
            o.sprintf2('ConstructorSuccess', o.N_Trows);

        end

        function defineMessages(o)
            o.addMessage('ConstructorSuccess','Table for cohort initialized with %d rows.');
            o.addMessage('SubjectMismatch','The subject provided: %s does not match subject found.');
            o.addMessage('SubjectMismatch','The subject provided: %s does match subject found.');
            o.addMessage('UnknownSubject','Sorry, I could not determine the name of the subject....');
            o.addMessage('SubjectCouldNotVerify','Subject was not provided, so I looked into a folder and put here what I found there: %s');
           
        end

        
        function addData(o,nv)
            % Adds a subject
            arguments
               o = []
               nv.RootDir (1,:) char = []; 
               nv.Format (1,:) char = []; 
               nv.Folder (1,:) char = [];
               nv.FullPath (1,:) char = [];
               nv.Subject (1,:) char = [];  %
               nv.Number (1,:) double = []; 
               nv.Treatment (1,:) char = [];
               nv.Role (1,:) char = []; 
               nv.Verbose (1,1) logical = false;
            end
            b_have_fullpath = false;
            b_have_pathSplitted = false;
            if ~isempty(nv.FullPath)  % if full path provided
                % parse full path
                nv.RootDir = previousPath(nv.FullPath,1);
                nv.Folder = previousPath(nv.FullPath,0);
                b_have_fullpath = true;
            end
            if ~isempty(nv.RootDir) && ~isempty(nv.Folder) % we have both
                b_have_pathSplitted = true;
            end

            b_canAddData = xor(b_have_fullpath,b_have_pathSplitted) && ~isempty(nv.Format) ; % requirement for adding data
            if b_canAddData
                % go go go
                ID_Tdat = table_getNextRow(Table = o.Tdat, Column = 'ID'); % we found next empty row
                nv.ID=ID_Tdat; % add ID so that it will be filled together
                o.Tdat = table_fillRowByFields(Table = o.Tdat, Row = nv.ID, DataStructure = nv);
                  
                o.VKJ_scanDataByID(ID = ID_Tdat); % look to the folder and gather other info
                b_addWhateverInTDatiAsSubject=false; % handel the Subject name
                if ~isempty(nv.Subject)  
                    if ~strcmp(nv.Subject,char(o.Tdati.Subject(ID_Tdat)))
                        o.disp2('ErrorHuge');
                        o.sprinf2('SubjectMismatch', nv.Subject);
                        b_addWhateverInTDatiAsSubject=false;
                    else
                        o.sprinf2('SubjectMatches', nv.Subject);
                        b_addWhateverInTDatiAsSubject=true;
                    end
                else
                    b_addWhateverInTDatiAsSubject=true;
                     o.disp2('Warning');
                     o.sprinf2('SubjectCouldNotVerify', o.Tdati.Subject(ID_Tdat) );
                end
                if b_addWhateverInTDatiAsSubject
                    % add Subject
                else
                     o.disp2('ErrorHuge');
                     o.sprinf2('UnknownSubject');
                end

               
            else
                o.disp2('MissingArguments');
                return
            end

        end

        function VKJ_scanDataByID(o,nv)
        % VKJ_scanDataBy
        % is played on cohort object only for VKJ format data
        % get the fucking info about one subject from cohort
        arguments
            o = []  % COHORT OBJECT o.Tdat table: RootDir, Folder and ID is expected here
            nv.ID double % this is Tdat ID
        end
        
        dd=dirfile([fullfile(char(o.Tdat.RootDir(nv.ID)),char(o.Tdat.Folder(nv.ID))) '\**\*.mat' ]);
        Nfiles  = numel(dd);
        info(Nfiles) = struct('subject',[], 'timeDn',[], 'station',[],'type',[]);
            % Get info from file names
            for i = 1:Nfiles
                [info(i).subject, info(i).timeDn, info(i).station, info(i).type] = VKJ_parseFileName(dd(i).name);          
            end
            onlyEegL = strcmp({info.type},'eeg');
            subjectsEegFilesC = {info(  onlyEegL   ).subject} ;
            % update Tdati
            o.Tdati.ID(nv.ID)  = nv.ID;
            o.Tdati.SingleSubject(nv.ID) = isequal(subjectsEegFilesC{:});
            o.Tdati.Files(nv.ID) = numel(subjectsEegFilesC);
            o.Tdati.Subject(nv.ID) = subjectsEegFilesC{1};

            startDns = [info(  onlyEegL   ).timeDn];
            startDns = sort(startDns);
            o.Tdati.StartDate{nv.ID} = datestr(startDns(1));
            o.Tdati.EndDate{nv.ID} = datestr(startDns(end));
            o.Tdati.TimeSpanDays(nv.ID) = startDns(end)-startDns(1);
            o.Tdati.TimeSpanDays(nv.ID) = startDns(end)-startDns(1);
            % Huge warning! this needs to be corrected, its a very bad guess!!!!
            o.Tdati.MinsPerFile(nv.ID) = mode(diff(startDns)) * 24*3600; 
            o.Tdati.TimeRawDays(nv.ID) = mode(diff(startDns)) * o.Tdati.Files(nv.ID);

            % update Tdat
            o.Tdat.ID(nv.ID)  = nv.ID;
            o.Tdat.Subject(nv.ID) = o.Tdati.Subject(nv.ID);
        end


        function assignRoleBy(o,nv)
            % 
            arguments
               o = []
               nv.Treatment (1,:) char = [];
               nv.RootDir (1,:) char = [];
               nv.Role (1,:) char = [];
            end
            if ~isempty(nv.Role) 
                if ~isempty(nv.Treatment) &&  ~isempty(nv.RootDir)
                    disp('error')
                    return
                end
                if ~isempty(nv.Treatment) % we have both
                    o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'Treatment',nv.Treatment,nv.Role)); % assigned 
                end
                if ~isempty(nv.RootDir) % we have both
                    o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'RootDir',nv.Treatment,nv.Role)); % assigned 
                end
            end
            function y = assignRoleByData_tableRow(Trow,Column,ColumnAskValue,Role)
                        if strcmp(Trow.(Column),ColumnAskValue)
                            Trow.Role = Role;
                        end
                        y = Trow; 
              end
 
        end





%%%%%%%%%%%%%%% end
end
end

