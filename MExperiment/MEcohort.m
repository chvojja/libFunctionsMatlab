classdef MEcohort < Verboser %& Tabler
    % MExperiment Summary of this class goes here
    %   Object holds information about a experimental subject
    
    properties

        Tsub; % table of the subjects
        Tdat; % table of the data to each mice
        Tdati; % table of the data with info about data dir

        TVKJ;
%         Tvkj; % VKJ related informations
%         Teeg; % eeg related informations

%         N_subj
%         N_subjInGroupCTRL
%         N_subjInGroupTREAT
        N_Trows = 5; % default number of rows

     

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

            o.Tsub = tableNewEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','Treatment','cat','Role','cat'); % one row per subject    
            o.Tdat = tableNewEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','Format','cat','Treatment','cat','RootDir','cat','Folder','cat','Scanned','logical'); % one row per data folder
            o.Tdati = tableNewEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','SingleSubject','logical','Files','double','StartDate','char','EndDate','char','TimeSpanDays','double','TimeRawDays','double','MinsPerFile','double','MissingFiles','logical'); % one row per data folder
%             o.T.eeg = tableNewEmpty(o.N_Trows,'Fs','double','Channels','cell','CountCh','double');
            o.TVKJ = tableNewEmpty(10,'ID','int64','ID_Tdat','int64','Subject','cat','Fs','double','Start','char','End','double','Channels','double','ChNames','cell','FilePath','char','HasLbl','double','FilePathLbl','char'); % one row per file

            

            o.sprintf2('ConstructorSuccess', o.N_Trows);

        end

        function defineMessages(o)
            o.addMessage('ConstructorSuccess','Table for cohort initialized with %d rows.');

            o.addMessage('CouldNotVerifySubject','Subject name was not provided, so I looked into a folder and put here what I found there: %s');
            o.addMessage('CouldNotVerifyNumber','Subject Number was not provided, so I looked into a folder and put here what I found there: %d');

           
            o.addMessage('MoreSubjectNumbers','I found more Numbers for the same Subject: %s');
            o.addMessage('UsingUsersNumber','The Number of the subject not found. Using the number provided by the user: %d');

            o.addMessage('AddedSubjectTsub','Added subject to Tsub: %s');
            o.addMessage('AddingData','Trying to add a data in the following path: %s    %s')
        end

        function save(o)

            %save([o.name '__COHORT__' date],o)
            save('cohort','o')

        end

        
        function addData(o,nv)
            % Adds a subject
            arguments % TODO - add validation functions
               o = []
               nv.RootDir (1,:) char = []; 
               nv.Format (1,:) {mustBeMember(nv.Format,{'VKJ','OSEL','putOtherFormatsHere'})} = 'VKJ'
               nv.Folder (1,:) char = [];
               nv.FullPath (1,:) char = [];
               nv.Subject (1,:) char = [];  %
               nv.Number (1,:) double = []; 
               nv.Treatment (1,:) char = [];
               nv.Role (1,:) char = []; 
               nv.Verbose (1,1) logical = false;
            end
            
            b_have_pathSplitted = false;
            if ~isempty(nv.RootDir) && ~isempty(nv.Folder) % we have both
                b_have_pathSplitted = true;
            end

            b_have_fullpath = false;
            if ~isempty(nv.FullPath)  % if full path provided
                % parse full path
                nv.RootDir = previousPath(nv.FullPath,1);
                nv.Folder = previousPath(nv.FullPath,0);
                b_have_fullpath = true;
            end

            b_canAddData = xor(b_have_fullpath,b_have_pathSplitted) && ~isempty(nv.Format) ; % requirement for adding data
            if b_canAddData
                % go go go
                o.sprintf2('Block2Start')
                o.sprintf2('AddingData',nv.RootDir,nv.Folder);
                ID_Tdat = nextRow(Table = o.Tdat,Key = 'ID'); % we found next empty row
                nv.ID=ID_Tdat; % add ID so that it will be filled together
                o.Tdat = fillRowNew(Sources = nv, Target = o.Tdat);
                %o.Tdat = table_fillRowByFields(Table = o.Tdat, Row = nv.ID, DataStructure = nv);
                switch nv.Format
                    case 'VKJ'
                         o.VKJ_scanVKJDataByID(ID = ID_Tdat); % look to the folder and gather other info - and store it in Tdati
                end

                %%  Compare user input (Tdat) and informations gathered by scanning the folder (Tdati)
                % Number
                number = missingEqual( o.Tdati.Number(ID_Tdat) , o.Tdat.Number(ID_Tdat) );
                if number.different
                            o.disp2('ErrorHuge');
                            o.disp2('Mismatch in Number');
                            o.disp2('Adding data aborted');
                            return
                end      
                if number.missing.left && number.having.right
                            o.disp2('Warning');
                            o.sprintf2('UsingUsersNumber', o.Tdat.Number(ID_Tdat));
                end
                if number.equal
                         o.disp2('Match in Number');
                end
                if number.having.left && number.missing.right
                         o.disp2('Warning');
                         o.sprintf2('CouldNotVerifyNumber', o.Tdati.Number(ID_Tdat));
                         o.Tdat.Number(ID_Tdat) = o.Tdati.Number(ID_Tdat);
                end
                if number.missing.both
                         o.disp2('ErrorHuge');
                         o.disp2('Missing Number, cant determine Number');
                         o.disp2('Adding data aborted');
                         return
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Subject
                subject = missingEqual( o.Tdati.Subject(ID_Tdat) , o.Tdat.Subject(ID_Tdat) );
                if subject.different
                            o.disp2('ErrorHuge');
                            o.disp2('Mismatch in Subject');
                            o.disp2('Adding data aborted');
                            return
                end      
                if subject.equal
                        o.disp2('Match in Subject');
                end
                if subject.having.left && subject.missing.right
                         o.disp2('Warning');
                         o.sprintf2('CouldNotVerifySubject', o.Tdati.Subject(ID_Tdat));
                         o.Tdat.Subject(ID_Tdat) = o.Tdati.Subject(ID_Tdat); 
                end
                if subject.missing.left
                         o.disp2('ErrorHuge');
                         o.disp2('Missing Subject, cant determine Subject');
                         o.disp2('Adding data aborted');
                         return
                end


                %% Add Subject and some other values if provided to Tsub
                %y = writeRow(Source = o.Tdat,Destination = o.Tsub,Key = 'Subject');
                o.Tsub = fillRowsByKeyOrAddNew(Sources = { o.Tdat(ID_Tdat,:) },Target=o.Tsub, Key='Subject'); 



                o.sprintf2('AddedSubjectTsub',char(o.Tdat.Subject(ID_Tdat)));
                %o.printvar(o.Tsub);
               
            else
                o.disp2('MissingArguments');
                o.disp2('Adding data aborted');
                return
            end
            o.sprintf2('Block2End')
        end


%         function cleanTables
%                             %% Delete redundant Subject and Number columns
%                 o.Tdati.Subject = [];
%                 o.Tdati.Number = [];
% 
%         end

        function VKJ_scanVKJDataByID(o,nv)
        % VKJ_scanVKJDataByID
        % is played on cohort object only for VKJ format data
        % get the fucking info about one subject from cohort
        % the function creates Tdati
        arguments
            o = []  % COHORT OBJECT o.Tdat table: RootDir, Folder and ID is expected here
            nv.ID double % this is Tdat ID
        end
        
        dd=dirfile([fullfile(char(o.Tdat.RootDir(nv.ID)),char(o.Tdat.Folder(nv.ID))) '\**\*.mat' ]);
        Nfiles  = numel(dd);
        

        info(Nfiles) = struct('subject',[],'number',[], 'timeDn',[], 'station',[],'type',[]);
            % Get info from file names
            for i = 1:Nfiles
                [info(i).subject, info(i).number, info(i).timeDn, info(i).station, info(i).type] = VKJ_parseFileName(dd(i).name);          
            end
            onlyEegL = strcmp({info.type},'eeg');
            subjectsEegFilesC = {info(  onlyEegL   ).subject} ;

            % update Tdati
            o.Tdati.ID(nv.ID)  = nv.ID;
            o.Tdati.SingleSubject(nv.ID) = isequal(subjectsEegFilesC{:});
            o.Tdati.Files(nv.ID) = numel(subjectsEegFilesC);
            SubjectFoundByScanning = subjectsEegFilesC{1};
            o.Tdati.Subject(nv.ID) = SubjectFoundByScanning;


            startDns = [info(  onlyEegL   ).timeDn];
            startDns = sort(startDns);
            o.Tdati.StartDate{nv.ID} = datestr(startDns(1));
            o.Tdati.EndDate{nv.ID} = datestr(startDns(end));
            o.Tdati.TimeSpanDays(nv.ID) = startDns(end)-startDns(1);
            o.Tdati.TimeSpanDays(nv.ID) = startDns(end)-startDns(1);
            % Huge warning! this needs to be corrected, its a very bad guess!!!!
            o.Tdati.MinsPerFile(nv.ID) = mode(diff(startDns)) * 24*3600; 
            o.Tdati.TimeRawDays(nv.ID) = mode(diff(startDns)) * o.Tdati.Files(nv.ID);


            notNaNidx=~isnan([info(  onlyEegL   ).number]);
            if ~isempty([info(notNaNidx).number])  % after removal of NaNs, If I found numbers
          
                if isequal(info(notNaNidx).number) % if all same
                    number = str2double(info(notNaNidx(1)).number);
                    o.Tdati.Number(nv.ID)  = number;
                else
                    o.sprintf2('MoreSubjectNumbers',char(o.Tdati.Subject(nv.ID)));
                end
            end
            
            

        end


%         function assignRoleBy(o,nv)
%             % 
%             arguments
%                o = []
%                nv.Treatment (1,:) char = [];
%                nv.RootDir (1,:) char = [];
%                nv.Role (1,:) char = [];
%             end
%       
%             if ~isempty(nv.Role) 
%                 if ~isempty(nv.Treatment) &&  ~isempty(nv.RootDir)
%                     disp2('Overspecified');
%                     return
%                 end
%                 
%                 if ~isempty(nv.Treatment) % we have
%                     o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'Treatment',nv.Treatment,nv.Role)); % assigned 
%                 end
%                 if ~isempty(nv.RootDir) % we have 
%                     o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'RootDir',nv.Treatment,nv.Role)); % assigned 
%                 end
%             end
%             function y = assignRoleByData_tableRow(Trow,Column,ColumnAskValue,Role)
%                         if strcmp(char(Trow.(Column)),ColumnAskValue)
%                             Trow.Role = Role;
%                         end
%                         y = Trow; 
%             end
%  
%         end


        function assignRoleBy(o,nv)
            % 
            arguments
               o = []
               nv.Treatment (1,:) char = [];
               nv.RootDir (1,:) char = [];
               nv.Role (1,:) char;
            end
      
            if ~isempty(nv.Role) 
                if ~isempty(nv.Treatment) &&  ~isempty(nv.RootDir)
                    disp2('Overspecified');
                    return
                end
                
                if ~isempty(nv.Treatment) % we have
                    o.Tsub = fillRowsByKey(Source = {'Treatment',nv.Treatment,'Role',nv.Role}, Key = 'Treatment',Target = o.Tsub);
          
                end
                if ~isempty(nv.RootDir) % we have 
                    o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'RootDir',nv.Treatment,nv.Role)); % assigned 
                end
            end

 
        end

%%%%%%%%%%%%%%% end
    
    end
end

