classdef FileIndexer < handle
    %NEURODATAPROVIDER1 Summary of this class goes here

    
    properties
        pathsS; % path struct
        %filesS=[]; % files struct
        Tfiles;
        temp_dir = 'C:\temp\FileIndexer';
        indexer_name;
        indexer_obj_path;
    end
    
    methods
        function obj = FileIndexer(name)
            %NEURODATAPROVIDER1 Construct an instance of this class
            %   Detailed explanation goes here
            obj.indexer_name = ['FileIndexer_' name];

            obj.indexer_obj_path = [obj.temp_dir '\' obj.indexer_name '.mat'];
            if isfile(obj.indexer_obj_path)
                load(obj.indexer_obj_path);
            end

        end


        function addDir(obj,dir_path)
            obj.pathsS=add2struct(obj.pathsS,'dir_path',dir_path);
        end


        function scan(obj)

            obj.Tfiles = [];
            N = numel(obj.pathsS);
            for i=1:N % fetch files from folders
                 obj.Tfiles = [ obj.Tfiles ; FileIndexer.getDirContentsBy_path( obj.pathsS(i).dir_path ) ];
            end

            % save
            mkdir(obj.temp_dir);
            save(obj.indexer_obj_path,'obj','-mat');


        end
    end

    methods (Static)

            function Tfiles = getDirContentsBy_path(root_path)
           
                dirContents=dir([root_path '\**\*']); 
                dirContents = dirContents(~[dirContents.isdir]);
        
                dirContents = rmfield(dirContents,{'isdir','date'});
                Tfiles = struct2table( dirContents );
            end

    end

end

