function y = fillRow(nv)
    %METHOD1 Summary of this method goes here
    %   Detailed explanation goes here
    % UniqueKey is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
    % if there exist a value in UniqueKey column that is same as a value of the Source data for UniqueKey column, the data is 
    % appended. If its not found, then a new row is created based on UniqueKey column
    arguments     
        nv.Sources; % struct or table or cell array of either struct or table 
        nv.Target table;
        nv.KeyColumn = 1;
    end
    
    %% Prepare data
    totalDataStruct = struct;
    if iscell(nv.Sources)
        Ns = numel(nv.Sources);
            for ns = 1:Ns
                src = nv.Sources{ns};
                className = class(src);
                switch  className  % convert if necessary
                    case 'table'
                        src = table2struct(src);
                    case 'struct'

                end
                totalDataStruct = mergeStructs(Source = src,Destination = totalDataStruct, Overwrite = false);
            end    
    else
        if isstruct(nv.Sources)
            totalDataStruct = nv.Sources;
        end
    end

    %% Now in totalDataStruct are all the source data
    % get row where to write
    rowNumber = nextRow(Table = nv.Target, KeyColumn = nv.KeyColumn);
    
  
    fieldsC = fieldnames(totalDataStruct);
    for kf = 1:numel(fieldsC)
         fieldName = fieldsC{kf};
        
         if any(strcmp(fieldName,Target.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
             Target.(fieldName)(rowNumber) = dataStructure.(fieldName);
             Target.ID(rowNumber) = rowNumber; 
         end
    end



end