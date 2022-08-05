classdef WKJiterateSubjectEEGfileObj < WKJiterateSubjectObj %handle
   properties
    
   fs;
   kf;
   eegFolderName;
   eegFileName;
   eegFileContent;
   eegFilePathName;
   fsDirContents
   eegNfiles;
   
   end 
   methods

       
       function iterateEEGfile(o)
                if isempty(o.fs) && numel(o.fsFolders)==1
                    o.fs = str2double(o.fsFolders{1});
                end
                o.fsDirContents=dir([o.subjPath '\' WKJfs2foldername(o.fs) '\*.mat']);
                o.eegNfiles=size(o.fsDirContents,1);
               
                for kf=1:o.eegNfiles
                o.eegFolderName = o.fsDirContents(kf).folder;
                o.eegFileName = o.fsDirContents(kf).name;
                o.eegFilePathName=fullfile(o.eegFolderName,o.eegFileName);
                o.kf = kf;

                onFileNext(o);
                end
       end
   end
   
   methods 
        function onFileNext(o)
                % Expected to be implemented in subclasses
        end
        function loadEEGfile(o)
                o.eegFileContent=load(o.eegFilePathName);
        end  
        
   end
end