classdef Analyzer %< handle
    %A Constants and Static methods for current analysis
    
    properties   (Abstract, Constant)
        % this needs to be defined in derived class
        %root = 'D:\temp_FCD_analyza_1';
        root;
        
    end

    properties (Constant)
        tempFileName = 'temp.mat';

    end

   

    methods (Static)

        function testInit()


            % Create the folder structure
            if ~isfolder(a.root)
                mkdir(a.root);
            end
            if ~isfile(  fullfile(a.root,  Analyzer.tempFileName  )   )
                analyzer.pwd.code=pwd; save(   fullfile(a.root,  Analyzer.tempFileName  ),'analyzer')
            else
                load(   fullfile(a.root,  Analyzer.tempFileName  ) ,   'analyzer')
                if ~strcmp(pwd,analyzer.pwd.code)
                        ME = MException('MyComponent:noSuchVariable', ...
                         'Path working directory (pwd) changed. Can not guarantee unique working enviroment.');
                         throw(ME);
                end
            end

        end

        function y  = p(x)  % base function for path
            Analyzer.testInit()
            y = fullfile(a.root,x);

             % Check if y is directory and create it if it does not exist
            if isDirPath(y) && ~isfolder(y)
                mkdir(y);
            end

        end

        function y  = pwd(x)  % Returns WorkingDirectory for the current analysis
            %FP create full path
            arguments
                x='';
            end
            y  = a.p(x);
        end
        
        function y  = ptmp()  % Returns FilePath to temp file for storing temporary shit
            % used like this: to store variable named 'i'  type:   save(a.mat,'i','-append')   
%             Analyzer.testInit()
%             y = fullfile(a.root, Analyzer.tempFileName  );
            y = a.p(Analyzer.tempFileName);
        end

        function error(x)
            disp('s',1541,15454,545)
        end




    end
end

