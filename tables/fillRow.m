function y = fillRow(nv)
    %METHOD1 Summary of this method goes here
    %   Detailed explanation goes here
    % KeyColumn is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
    % if there exist a value in KeyColumn column that is same as a value of the Source data for UniqueKey column, the data is 
    % appended. If its not found, then a new row is created based on KeyColumn column.
    % If KeyColumn is not specified than, we will look to the first column
    arguments     
        nv.Sources; % struct or table row or cell array of either struct or table 
        nv.TableTarget table;
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
        if strcmp(nv.KeyColumn,nv.TableTarget.Properties.VariableNames)
            if isfield(totalDataStruct,nv.KeyColumn) % under this the source data has valid field
                val = totalDataStruct.(nv.KeyColumn);
                class_KeyColumn = class(nv.TableTarget.(nv.KeyColumn));

                if ismember(class_KeyColumn,{'categorical','char','double'}) && ismember(val,{'categorical','char','double'}) % the typeis correct
                    matchRow = find(ismember(nv.TableTarget.(nv.KeyColumn),val));
                    if numel(matchRow) == 1 % here we should update this row by the new data
                        rowNumber = matchRow;
                    end

                    if isempty(matchRow) % here we should write to new row
                        rowNumber = nextRow(Table = nv.TableTarget, KeyColumn = nv.KeyColumn);
                    end
                end
            else
                disp2(nv.Verbose,'Provided KeyColumn not found in source data structure')
            end
            
        end
    end
    if isdouble(nv.KeyColumn)
        rowNumber = nextRow(Table = nv.TableTarget, KeyColumn = nv.KeyColumn);
    end

    
    
  
    fieldsC = fieldnames(totalDataStruct);
    for kf = 1:numel(fieldsC)
         fieldName = fieldsC{kf};

         if isfieldt(TableTarget,fieldName) 
             if ismissingt(TableTarget.(fieldName)(rowNumber))
                b_canWrite = true;
             else
                 if nv.Overwrite
                     b_canWrite = true;
                 else
                     b_canWrite = false;
                 end
             end
             if b_canWrite
                 TableTarget.(fieldName)(rowNumber) = totalDataStruct.(fieldName);
             end
         else
             disp2(nv.Verbose,'Column not present both in Source and Target')
         end
    end

            
        
         if any(strcmp(fieldName,TableTarget.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
             
             TableTarget.ID(rowNumber) = rowNumber; 
         end
    end



end