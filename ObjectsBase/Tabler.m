classdef Tabler < handle
    %TABLER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        tabler;
    end
    
    methods

        
        function y = fillRow(o,nv)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            % UniqueKey is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
            % if there exist a value in UniqueKey column that is same as a value of the Source data for UniqueKey column, the data is 
            % appended. If its not found, then a new row is created based on UniqueKey column
            arguments
                o
                nv.Sources;
                nv.Target;
                nv.UniqueKey = 1; 
            end
            
            if ischar(nv.Sources)
                    %src = nv.Sources;
                    o.fillRowFromOneSource(nv.Sources,nv.Target,nv.UniqueKey);
            end
            if iscell(nv.Sources)
                    for ns =1:Ns
                        src = nv.Sources{ns};
                        nvOne = nv;
                        ovOne.Source = src;
                        y = o.fillRowFromOneSource(nvOne);

                    end
            end

        end

    end
   

    methods (Access = private)

        
        function Target  = fillRowFromOneSource(o,Source,Target,UniqueKey)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here

            %rowNumber = table_getNextRow(Table = Target, Column = 'ID'); 
%             if isempty
            if istable(Source)
                dataStructure = table2struct(Source);
            end
          

            rowNumber = nextRow("Table",o.(Target),"Column",UniqueKey);

            fields = fieldnames(dataStructure);
            for kf = 1:numel(fields)
                 fieldName = fields{kf};
                
                 if any(strcmp(fieldName,Target.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
                     Target.(fieldName)(rowNumber) = dataStructure.(fieldName);
                     Target.ID(rowNumber) = rowNumber; 
                 end
            end


        end

    end




end




