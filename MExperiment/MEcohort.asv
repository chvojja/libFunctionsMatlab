classdef MEcohort < Verboser %& Tabler
    % MExperiment Summary of this class goes here
    %   Object holds information about a experimental subject
    
    properties

        Tsub; % table of the subjects
        Tdat; % table of the data to each mice
        Tdati; % table of the data with info about data dir

        VKJeeg;
        VKJlbl;

%         Tvkj; % VKJ related informations
%         Teeg; % eeg related informations

%         N_subj
%         N_subjInGroupCTRL
%         N_subjInGroupTREAT
        %N_Trows = 5; % default number of rows

     

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

            o.Tsub = tableNewEmpty('ID','double','Subject','cat','Number','double','Treatment','cat','Role','cat', Nrows = 1); % one row per subject    
            o.Tdat = tableNewEmpty('ID','double','Subject','cat','Number','double','Format','cat','Treatment','cat','RootDir','cat','Folder','cat','Scanned','logical', Nrows = 10); % one row per data folder
            o.Tdati = tableNewEmpty('ID','double','Subject','cat','Number','double','SingleSubject','logical','Files','double','StartDate','char','EndDate','char','TimeSpanDays','double','TimeRawDays','double','MinsPerFile','double','MissingFiles','logical', Nrows = 10); % one row per data folder
%             o.T.eeg = tableNewEmpty(o.N_Trows,'Fs','double','Channels','cell','CountCh','double');
            o.VKJeeg = tableNewEmpty('ID','uint32','Tdat_ID','uint32','Subject','cat','Start','char','End','char','Channels','double','ChNames','cell','FilePath','char','SubFold1','cat','SubFold2','cat','Dev','cat', Nrows = 10); %'HasLbl','double','FilePathLbl','char'); % one row per file
            o.VKJlbl = tableNewEmpty('ID','uint32','Tdat_ID','uint32','VKJeeg_ID','uint32','Subject','cat','FilePath','char','SubFold1','cat','SubFold2','cat', Nrows = 1); %'HasLbl','double','FilePathLbl','char'); % one row per file

            

            

        end

        function defineMessages(o)
           

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
                %rTdat = nextRow(Table = o.Tdat); % we found next empty row
                %nv.ID=rTdat; % add ID so that it will be filled together
                %[o.Tdat, rTdat] = fillRowNew(Sources = {nv, struct('ID',rTdat.id)} , Target = o.Tdat);
                [o.Tdat, rTdat] = fillRowNew(Sources = nv , Target = o.Tdat); % ID will be filled automatically
                %o.Tdat = table_fillRowByFields(Table = o.Tdat, Row = nv.ID, DataStructure = nv);
                switch nv.Format
                    case 'VKJ'
                         o.VKJ_scanVKJDataByID(ID = rTdat.id); % look to the folder and gather other info - and store it in Tdati
                end

                %%  Compare user input (Tdat) and informations gathered by scanning the folder (Tdati)
                % Number  o.Tdat.ID==nv.ID
                number = missingEqual( o.Tdati.Number(rTdat.row) , o.Tdat.Number(rTdat.row) );
                if number.different
                            o.disp2('ErrorHuge');
                            o.disp2('Mismatch in Number');
                            o.disp2('Adding data aborted');
                            return
                end      
                if number.missing.left && number.having.right
                            o.disp2('Warning');
                            o.sprintf2('UsingUsersNumber', o.Tdat.Number(rTdat.row));
                end
                if number.equal
                         o.disp2('Match in Number');
                end
                if number.having.left && number.missing.right
                         o.disp2('Warning');
                         o.sprintf2('CouldNotVerifyNumber', o.Tdati.Number(rTdat.row));
                         o.Tdat.Number(rTdat.row) = o.Tdati.Number(rTdat.row);
                end
                if number.missing.both
                         o.disp2('ErrorHuge');
                         o.disp2('Missing Number, cant determine Number');
                         o.disp2('Adding data aborted');
                         return
                end

                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % Subject
                subject = missingEqual( o.Tdati.Subject(rTdat.row) , o.Tdat.Subject(rTdat.row) );
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
                         o.sprintf2('CouldNotVerifySubject', o.Tdati.Subject(rTdat.row));
                         o.Tdat.Subject(rTdat.row) = o.Tdati.Subject(rTdat.row); 
                end
                if subject.missing.left
                         o.disp2('ErrorHuge');
                         o.disp2('Missing Subject, cant determine Subject');
                         o.disp2('Adding data aborted');
                         return
                end


                %% Add Subject and some other values if provided to Tsub
                %y = writeRow(Source = o.Tdat,Destination = o.Tsub,Key = 'Subject');
                o.Tsub = fillRowsByKeyOrAddNew(Sources = { o.Tdat(rTdat.row,:) },Target=o.Tsub, Key='Subject'); 

                o.sprintf2('AddedSubjectTsub',char(o.Tdat.Subject(rTdat.row)));
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
            nv.Tdat_ID double % this is Tdat row
        end

        
        [o.Tdat, rTdat] = rowInit(o.Tdat);
        
        dd=dirfile([fullfile(char(o.Tdat.RootDir(nv.ID)),char(o.Tdat.Folder(nv.ID))) '\**\*.mat' ]);
        Nfiles  = numel(dd);
        

        %info(Nfiles) = struct('Subject',[],'Number',[], 'timeDn',[], 'station',[],'type',[]);
            % Get info from file names
            for i = 1:Nfiles
                [info(i).Subject, info(i).Number, info(i).Start, info(i).Dev, info(i).Type ] = VKJ_parseFileName(dd(i).name);   

                info(i).FilePath = [dd(i).folder filesep dd(i).name];
                sf = subFolders( FilePath = info(i).FilePath,  Offset = [fullfile(char(o.Tdat.RootDir(nv.ID)),char(o.Tdat.Folder(nv.ID))) ]  );
                [info(i).SubFold1 , info(i).SubFold2] = dealsome(sf);
                %info(i).ID = i;
                info(i).Tdat_ID = nv.ID;

                %o.VKJeeg = fillRowNew(Sources = info(i),Target = o.VKJeeg);
            end

            TfilesOneSub = categorify(struct2table(info));

            oneSub_eegL = TfilesOneSub.Type =='eeg';
            o.VKJeeg = tableAppend(Source = TfilesOneSub(oneSub_eegL, :), Target = o.VKJeeg);

            % update Tdati
            [o.Tdati, rTdati] = rowInit(o.Tdati);
            o.Tdati.ID(rTdati.row)  = nv.ID;
            o.Tdati.SingleSubject(rTdati.row) = all(TfilesOneSub.Subject == TfilesOneSub.Subject(1));
            o.Tdati.Files(rTdati.row) = size(TfilesOneSub,1);
            SubjectFoundByScanning = char(TfilesOneSub.Subject(1));
            o.Tdati.Subject(rTdati.row) = SubjectFoundByScanning;


            startDns = datenum(    char(    TfilesOneSub{oneSub_eegL, 'Start'}     )     );
            startDns = sort(startDns);
            o.Tdati.StartDate{rTdati.row} = datestr(startDns(1));
            o.Tdati.EndDate{rTdati.row} = datestr(startDns(end));
            o.Tdati.TimeSpanDays(rTdati.row) = startDns(end)-startDns(1);
            o.Tdati.TimeSpanDays(rTdati.row) = startDns(end)-startDns(1);
            % Huge warning! this needs to be corrected, its a very bad guess!!!!
            o.Tdati.MinsPerFile(rTdati.row) = mode(diff(startDns)) * 24*3600; 
            o.Tdati.TimeRawDays(rTdati.row) = mode(diff(startDns)) * o.Tdati.Files(rTdati.row);

            nonNaNnumbers = TfilesOneSub.Number(  ~isnan(TfilesOneSub.Number)   );
            if numel(nonNaNnumbers)>0
                if all(  TfilesOneSub.Number == TfilesOneSub.Number(1)  )
                    o.Tdati.Number(rTdati.row) =  TfilesOneSub.Number(1);
                    else
                        o.sprintf2('MoreSubjectNumbers',char(o.Tdati.Subject(rTdati.row)));
                end
            end
 
        end



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

