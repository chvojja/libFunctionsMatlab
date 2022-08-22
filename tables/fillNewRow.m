function y = fillNewRow(nv)
    %FILLROWS This function fill a row(s) of a table Target with named columns by anything that is in Sources cell array.
    % There can be a structure or a table in this cell array. Any value that is under a field that is also a column in Target is filled 
    % into that row(s), and every value of the same named column is filled in Target if source is a table row. More simply, three modes
    % exists:
    % 1. The KeyColumn is either notprovided or its corresponding value is not fond - in this case a new row is created and filled with
    % Sources.
    % 2. A matching row that corresponds to KeyColumn is found - and OverwriteExisting is false = that row is only made more data - rich with Sources.
    % 3. A matching row that corresponds to KeyColumn is found - and OverwriteExisting is true = the row values are updated with data under Sources.
    %
    % KeyColumn is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
    % if there exist a value in KeyColumn column that is same as a value of the Source data for KeyColumn column, the data is 
    % appended. If its not found, then a new row is created based on KeyColumn column.
    % If KeyColumn is not specified than, we will look to the first column
    arguments     
        nv.Sources; % struct or table row or cell array of either struct or table row 
        nv.Target table;
        nv.KeyColumn {double, char} = 1; % this Column name identifies the new data in the context of existing table 
        nv.OverwriteExisting = true;
        nv.AllowNewRowIfKeyColumnNotFound = false;
        nv.Verbose = true;

    end
    
    %% Prepare data
       totalDataStruct = glueFields(nv.Sources);   
       
    %% Now in totalDataStruct are all the source data
    % Chceck if corresponding row to source data via KeyColumn exists 
    % Determine the row where to write
    if ischar(nv.KeyColumn)
        if ismember(nv.KeyColumn,nv.Target.Properties.VariableNames)
            if isfield(totalDataStruct,nv.KeyColumn) % under this the source data has valid field
                val = totalDataStruct.(nv.KeyColumn);

                if ismember( class(nv.Target.(nv.KeyColumn)) ,{'categorical','char','double'}) && ismember(class(val),{'categorical','char','double'}) % the typeis correct
                    matchRows = find(ismember(nv.Target.(nv.KeyColumn),val));
                    if numel(matchRows) >= 1 % here we should update this row by the new data
                        rowNumbers = matchRows;
                    end

                    if isempty(matchRows) % here we should write to a new row
                        rowNumbers = nextRow(Table = nv.Target, KeyColumn = nv.KeyColumn);
                    end
                end
            else
                disp2(nv.Verbose,['Provided KeyColumn not found in source data structure' nv.KeyColumn ])
            end
            
        end
    else
        if nv.KeyColumn == 1 % if KeyColumn not specified
            rowNumbers = nextRow(Table = nv.Target, KeyColumn = nv.KeyColumn);
        end
    end

    % We have rowNumbers
    
    % Updateing the Target from the Sources
    fieldsC = fieldnames(totalDataStruct);
    for kf = 1:numel(fieldsC)
         fieldName = fieldsC{kf};

         if isfieldt(nv.Target,fieldName) 

            for kr = 1: numel(rowNumbers)
                 if ismissingt(nv.Target.(fieldName)(rowNumbers(kr)))
                    b_canWrite = true;
                 else
                     if nv.OverwriteExisting
                         b_canWrite = true;
                     else
                         b_canWrite = false;
                     end
                 end
                 if b_canWrite
                     nv.Target.(fieldName)(rowNumbers(kr)) = totalDataStruct.(fieldName);
                 end
            end


         else
             disp2(nv.Verbose,['Column ' fieldName ' not present in Target.' ])
         end
    end

            
   y = nv.Target;     


end