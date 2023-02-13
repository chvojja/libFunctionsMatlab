classdef fileCacher < handle
    %FILECACHER
    % Assumtions
    %
    % FilePaths is list of all files that we are going to work with.
    % Fun is fun that does something with the file
    %
    % CmdWinTool('isBusy'); to determine if Matlab is busy
    
    properties
        % this is subindexed by fs:
        FilePaths;
        Files;
        filesLoadedL; % logicals to determine if files are loaded or not
        fcounter = 0;
        
        filesIndexesOldToNew;
        Nf; % number of files

        Fun;

        MemLimit = 200; % MB
        freeRatio = 0.1; % everytime memory limit is reached, 20percent of files are kept.
    end
    
    methods
        function obj = fileCacher(nv)
                arguments
                    % user can provide either this
                    nv.FilePaths;
                    nv.Fun;
                end
                   
                % validation of FileTables

                % Save
                obj.FilePaths = nv.FilePaths;
                obj.Nf = numel(nv.FilePaths);
                obj.Files = cell(obj.Nf,nargout(nv.Fun));
                obj.filesLoadedL = false(obj.Nf,1);
                obj.Fun = nv.Fun;
               
                obj.filesIndexesOldToNew = zeros(obj.Nf,1);
                
        end


        
        function varargout = get(obj,filePath)

             fileI = find( obj.FilePaths == filePath );

             if obj.filesLoadedL(fileI)
                 varargout = { obj.Files{fileI,:} };
             else
               [obj.Files{fileI,:}]  = obj.Fun(char(filePath)); %   {ifn,:} 
                 varargout= { obj.Files{fileI,:} };
                 obj.filesLoadedL(fileI) = true;
                 obj.fcounter = obj.fcounter +1;
                 obj.filesIndexesOldToNew(obj.fcounter) = fileI;
                 
                 totSize = obj.GetSize();
                 %totSize = 0;

                 if totSize > obj.MemLimit
                     obj.deleteOlder()
                 end

             end
             
             
   

        end
        
        function deleteOlder(obj)

                 toDelete = ceil((1-obj.freeRatio)*obj.fcounter);      

                 toDeleteI = obj.filesIndexesOldToNew(1:toDelete);
                 
                 % delete          
                 [obj.Files{toDeleteI,:}]=deal([]);
                 obj.filesLoadedL(toDeleteI) = false;

                 % rearrange 
                 temp = obj.filesIndexesOldToNew((toDelete+1):obj.fcounter);
                 obj.filesIndexesOldToNew = zeros(obj.Nf,1);
                 if ~isempty(temp)
                    obj.filesIndexesOldToNew(  1:(obj.fcounter - toDelete) ) = temp;
                 end
                 obj.fcounter  = length(temp);
        end

        function y = GetSize(obj) 
           props = properties(obj); 
           totSize = 0; 
           
           for ii=1:length(props) 
              currentProperty = getfield(obj, char(props(ii))); 
              s = whos('currentProperty'); 
              totSize = totSize + s.bytes; 
           end
           y = round( totSize/(1024^2)  ); % in MB
           %fprintf(1, '%d MBytes\n',  y   ); 
        end




    end
end

