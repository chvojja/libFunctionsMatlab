classdef MEcohort < Verboser
    % MExperiment Summary of this class goes here
    %   Object holds information about a experimental subject
    
    properties

        Tsub; % table of the subjects
        Tdat; % table of the data to each mice
        Tdati; % table of the data with info about data dir
%         Tvkj; % VKJ related informations
%         Teeg; % eeg related informations

%         N_subj
%         N_subjInGroupCTRL
%         N_subjInGroupTREAT
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
            o.Tdat = table_createEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','Format','cat','Treatment','cat','RootDir','cat','Folder','cat','Scanned','logical'); % one row per data folder
            o.Tdati = table_createEmpty(o.N_Trows,'ID','double','Subject','cat','Number','double','SingleSubject','logical','Files','double','StartDate','char','EndDate','char','TimeSpanDays','double','TimeRawDays','double','MinsPerFile','double','MissingFiles','logical'); % one row per data folder
%             o.T.eeg = table_createEmpty(o.N_Trows,'Fs','double','Channels','cell','CountCh','double');
            
            o.sprintf2('ConstructorSuccess', o.N_Trows);

        end

        function defineMessages(o)
            o.addMessage('ConstructorSuccess','Table for cohort initialized with %d rows.');
            o.addMessage('MismatchSubject','The subject provided: %s does not match subject found.');
            o.addMessage('MismatchNumber','The number provided: %d does not match the number found.');
            o.addMessage('MatchesSubject','The subject provided: %s does match subject found.');
            o.addMessage('MatchesNumber','The number provided: %d does match the number found.');

            o.addMessage('UnknownSubject','Sorry, I could not determine the name of the subject....');
            o.addMessage('UnknownNumber','Sorry, I could not determine the number of the subject....');

            o.addMessage('CouldNotVerifySubject','Subject was not provided, so I looked into a folder and put here what I found there: %s');
            o.addMessage('AddedSubjectTsub','Added subject to Tsub: %s');
            o.addMessage('NotFoundSubjectNumber','The number for subject: %s was not found.');
            o.addMessage('FoundSubjectNumber','The number for subject: %s is: %d');
            o.addMessage('MismatchSubjectNumber','I found more numbers for the same subject: %s');
            o.addMessage('UsingUsersNumber','Number of the subject not found. Using the number provided by the user: %d');
            o.addMessage('AddingData','Trying to add a data in the following path: %s    %s')
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
                o.sprintf2('AddingData',nv.RootDir,nv.Folder);
                ID_Tdat = table_getNextRow(Table = o.Tdat, Column = 'ID'); % we found next empty row
                nv.ID=ID_Tdat; % add ID so that it will be filled together
                o.Tdat = table_fillRowByFields(Table = o.Tdat, Row = nv.ID, DataStructure = nv);
                 
                o.VKJ_scanVKJDataByID(ID = ID_Tdat); % look to the folder and gather other info - and store it in Tdati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %table_resolveConflict(o.Tdati(ID_Tdat,:),o.Tdat(ID_Tdat,:),'MV')
                res  = table_compareFun(Obj=o, Left = 'Tdati', Right = 'Tdat', ID = ID_Tdat,...
                    onMissingLeftHavingRight={ @(x)userProvidedNumber(o,x), },...
                    onSame= @(x)onSameNumber(o)     );
  


%                 if ~isempty( o.Tdati.Subject(ID_Tdat) ) && 
% 
%                 end
                % Number


            

                if different.Number
                            o.disp2('ErrorHuge');
                            o.sprintf2('MismatchNumber', nv.Number);
                            return
                end
                if missing.Number==0b10
                            o.disp2('Warning');
                            o.sprintf2('UsingNumberByUser', nv.Number);
                end
                if same.Number
                        o.sprintf2('MatchesNumber', nv.Number);
                end
                if missing.Number==0b01
                         o.disp2('Warning');
                         o.sprintf2('CouldNotVerifyNumber', NumberFoundByScanning );
                end
                if missing.Number==0b11
                         o.disp2('ErrorHuge');
                         o.sprintf2('UnknownNumber');
                         return
                end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                SubjectFoundByScanning = char(o.Tdati.Subject(ID_Tdat));
                if isempty(SubjectFoundByScanning)
                     o.disp2('ErrorHuge');
                     o.sprintf2('UnknownSubject');
                     return
                end

                NumberFoundByScanning = o.Tdat.Number(ID_Tdat); % it is permitted not to find a number, in this case, the user should provide
                %b_addWhateverInTDatiAsSubject=false; 
                


                % Number
                if ~isempty(nv.Number) % handle the Number provided by user 
                    if ~isnan(NumberFoundByScanning)
                        if nv.Number~=NumberFoundByScanning
                            o.disp2('ErrorHuge');
                            o.sprintf2('MismatchNumber', nv.Number);
                            return
                        else
                            o.disp2('Warning');
                            o.sprintf2('UsingNumberProvided', nv.Number);
                            Number = NumberFoundByScanning;
                        end
                    else
                        o.sprintf2('MatchesNumber', nv.Number);
                        Number = NumberFoundByScanning;
                    end
                else
                    if ~isempty(NumberFoundByScanning) % using what we found
                         o.disp2('Warning');
                         o.sprintf2('CouldNotVerifyNumber', NumberFoundByScanning );
                         Number = NumberFoundByScanning;
                    else
                         o.disp2('ErrorHuge');
                         o.sprintf2('UnknownNumber');
                         return
                    end
                end



                    % add Subject and some other values if provided
                    valuesForTsub.Subject = SubjectFoundByScanning;
                    valuesForTsub.Number = Number;
                    valuesForTsub.Role = nv.Role;
                    valuesForTsub.Treatment = nv.Treatment;
                    o.Tsub = table_fillNewRowByFields(Table = o.Tsub, DataStructure = valuesForTsub);
                    o.sprintf2('AddedSubjectTsub',SubjectFoundByScanning);
                    %o.printvar(o.Tsub);
               
            else
                o.disp2('MissingArguments');
                return
            end
            % Functions overrridings
            function userProvidedNumber(o,tableResults)
                        o.disp2('Warning');
                        o.sprintf2('UsingUsersNumber', tableResults.Number);

            end
            function onSameNumber(o,res)
                        o.disp2('Warning');
                        o.sprintf2('UsingUsersNumber', nv.Number);

            end

        end

        function VKJ_scanVKJDataByID(o,nv)
        % VKJ_scanDataBy
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

            % dodelat
%             % Subject
%             if ~isempty(nv.Subject) % handle the Subject name provided by user
%                 if ~strcmp(nv.Subject,SubjectFoundByScanning)
%                     o.disp2('ErrorHuge');
%                     o.sprintf2('MismatchSubject', nv.Subject);
% 
%                     %b_addWhateverInTDatiAsSubject=false;
%                     return
%                 else
%                     o.sprintf2('MatchesSubject', nv.Subject);
%                     %b_addWhateverInTDatiAsSubject=true;
%                 end
%             else
%                 %b_addWhateverInTDatiAsSubject=true;
%                  o.disp2('Warning');
%                  o.sprintf2('CouldNotVerifySubject', SubjectFoundByScanning );
%             end
%             char(o.Tdati.Subject(ID_Tdat));
%             if isempty(SubjectFoundByScanning)
%                  o.disp2('ErrorHuge');
%                  o.sprintf2('UnknownSubject');
%                  return
%             end

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

            notNaNidx=~isnan([info(  onlyEegL   ).number]);
            if ~isempty([info(notNaNidx).number])  % after removal of NaNs, If I found numbers
          
                if isequal(info(notNaNidx).number) % if all same
                    number = str2double(info(notNaNidx(1)).number);
                    o.Tdat.Number(nv.ID)  = number;
                    o.sprintf2('FoundSubjectNumber',char(o.Tdat.Subject(nv.ID)), number);
                else
                    o.sprintf2('MismatchSubjectNumber',char(o.Tdat.Subject(nv.ID)));
                end
            else
                o.sprintf2('NotFoundSubjectNumber',char(o.Tdat.Subject(nv.ID)));
            end
            

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
                    disp2('Overspecified');
                    return
                end
                
                if ~isempty(nv.Treatment) % we have
                    o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'Treatment',nv.Treatment,nv.Role)); % assigned 
                end
                if ~isempty(nv.RootDir) % we have 
                    o.Tsub = table_rowfun(Table = o.Tsub, Function = @(x)assignRoleByData_tableRow(x,'RootDir',nv.Treatment,nv.Role)); % assigned 
                end
            end
            function y = assignRoleByData_tableRow(Trow,Column,ColumnAskValue,Role)
                        if strcmp(char(Trow.(Column)),ColumnAskValue)
                            Trow.Role = Role;
                        end
                        y = Trow; 
              end
 
        end





%%%%%%%%%%%%%%% end
    
    end
end

