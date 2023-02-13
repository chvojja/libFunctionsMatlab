classdef NeurodataIndexer < FileIndexer
    %NEURODATAPROVIDER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
     
    end
    
    methods
%         function obj = NeurodataIndexer(name)
%             %NEURODATAPROVIDER Construct an instance of this class
%             obj = obj@FileIndexer(name);
%         end
        
    end

    methods (Static)

            function Tfiles = getDirContentsBy_path(root_path)
            
     
                dirContents_lbl3=dir([root_path '\**\*.mat']); 
        
                for i = 1:size(dirContents_lbl3,1)
                
                    folder_root  = previousFolder(root_path,0);
                    [ ~ , path_rest ] = splitpath(  dirContents_lbl3(i).folder   , ByFolder= folder_root );
                    
                    subjectNumber = regexp( nextFolder(path_rest,0) , '\d\d\d','match','once') ;
                    
                    b_lbl3 = isempty( regexp( path_rest , 'lbl3.mat\>') );
        
                    dirContents_lbl3(i).etag = str2double(subjectNumber);
                    dirContents_lbl3(i).folder_root = folder_root;
                    dirContents_lbl3(i).folder_last = previousFolder( path_rest ,0);
                    dirContents_lbl3(i).folder_beforelast = previousFolder( path_rest ,1);
                    dirContents_lbl3(i).islbl3 = b_lbl3;
                    dirContents_lbl3(i).fpath =  [ dirContents_lbl3(i).folder '\' dirContents_lbl3(i).name ];
        
                end
                Tfiles = struct2table(dirContents_lbl3);
            end

    end



end

