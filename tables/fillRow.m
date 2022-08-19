function y = fillRow(nv)
    %METHOD1 This function fill a row of a table TargetTable with named columns by anything that is in Sources cell array.
    % There can be a structure or a table in this cell array. Any value that is under a field that is also a colun in TargetTable is filed 
    % into that row, and every value of the same named column is filled in TargetTable if source is a table. More simply, three modes
    % exists:
    % 1. The KeyColumn is either notprovided or its corresponding value is not fond - in this case a new row is created and filled with
    % Sources.
    % 2. A matching row that corresponds to KeyColumn is found - and Overwrite is false = that row is only made more data - rich with Sources.
    % 3. A matching row that corresponds to KeyColumn is found - and Overwrite is true = the row values are updated with data under Sources.
    %
    % KeyColumn is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
    % if there exist a value in KeyColumn column that is same as a value of the Source data for KeyColumn column, the data is 
    % appended. If its not found, then a new row is created based on KeyColumn column.
    % If KeyColumn is not specified than, we will look to the first column
    arguments     
        nv.Sources; % struct or table row or cell array of either struct or table 
        nv.TargetTable table;
        nv.KeyColumn {double, char} = 1; % this Column name identifies the new data in the context of existing table 
        nv.Overwrite = true;
        nv.Verbose = true;
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
    % Chceck if corresponding row to source data via KeyColumn exists
    if ischar(nv.KeyColumn)
        if strcmp(nv.KeyColumn,nv.TargetTable.Properties.VariableNames)
            if isfield(totalDataStruct,nv.KeyColumn) % under this the source data has valid field
                val = totalDataStruct.(nv.KeyColumn);
                class_KeyColumn = class(nv.TargetTable.(nv.KeyColumn));

                if ismember(class_KeyColumn,{'categorical','char','double'}) && ismember(val,{'categorical','char','double'}) % the typeis correct
                    matchRow = find(ismember(nv.TargetTable.(nv.KeyColumn),val));
                    if numel(matchRow) == 1 % here we should update this row by the new data
                        rowNumber = matchRow;
                    end

                    if isempty(matchRow) % here we should write to new row
                        rowNumber = nextRow(Table = nv.TargetTable, KeyColumn = nv.KeyColumn);
                    end
                end
            else
                disp2(nv.Verbose,'Provided KeyColumn not found in source data structure')
            end
            
        end
    end
    if isnumeric(nv.KeyColumn)
        rowNumber = nextRow(Table = nv.TargetTable, KeyColumn = nv.KeyColumn);
    end

    
    
  
    fieldsC = fieldnames(totalDataStruct);
    for kf = 1:numel(fieldsC)
         fieldName = fieldsC{kf};

         if isfieldt(nv.TargetTable,fieldName) 
             if ismissingt(nv.TargetTable.(fieldName)(rowNumber))
                b_canWrite = true;
             else
                 if nv.Overwrite
                     b_canWrite = true;
                 else
                     b_canWrite = false;
                 end
             end
             if b_canWrite
                 nv.TargetTable.(fieldName)(rowNumber) = totalDataStruct.(fieldName);
             end
         else
             disp2(nv.Verbose,'Column not present both in Source and Target')
         end
    end

            
        


end