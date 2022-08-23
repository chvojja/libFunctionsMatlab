function [y, b_keyRowsFound] = fillRowsByKey(nv)
    %FILLROWS This function fill a row(s) of a table Target with named columns by anything that is in Sources cell array.
    % There can be a structure or a table in this cell array. Any value that is under a field that is also a column in Target is filled 
    % into that row(s), and every value of the same named column is filled in Target if source is a table row. More simply, three modes
    % exists:
    % 1. The Key is either notprovided or its corresponding value is not fond - in this case a new row is created and filled with
    % Sources.
    % 2. A matching row that corresponds to Key is found - and Overwriting is false = that row is only made more data - rich with Sources.
    % 3. A matching row that corresponds to Key is found - and Overwriting is true = the row values are updated with data under Sources.
    %
    % Key is name of the Column, that  is used to determine whethwer to append the data to existing row or to fill a new row
    % if there exist a value in Key column that is same as a value of the Source data for Key column, the data is 
    % appended. If its not found, then a new row is created based on Key column.
    % If Key is not specified than, we will look to the first column
    arguments     
        nv.Sources = []; % struct or table row or cell array of either struct or table row 
        nv.Source = []; % even element cell array of Key-Value pairs
        nv.Target table;
        nv.Key {double, char}; % this Column name identifies the new data in the context of existing table 
        nv.Overwriting = false;
        nv.Verbose = false;

    end

    b_keyRowsFound = false;
    y = [];
 
     %% Prepare data
     if (  isempty(nv.Sources) && isempty(nv.Source)   )
         disp2(nv.Verbose,'Not enough arguments');
         return
     else
        totalDataStruct = [];
        if ~isempty(nv.Sources)
            totalDataStruct = fields2struct(Sources = nv.Sources,OverwriteSameFields = nv.Overwriting); 
        end
        if ~isempty(nv.Source)
            singleSourceStruct = cell2namedargs(nv.Source);  
            totalDataStruct = structMerge(Source=singleSourceStruct,Target = totalDataStruct,OverwriteSameFields=nv.Overwriting);
        end     
     end

    %% Now in totalDataStruct are all the source data as a single structure
    % Chceck if corresponding row to source data via Key exists 
    % Determine the row where to write
    if ischar(nv.Key)
        if ismember(nv.Key,nv.Target.Properties.VariableNames)
            if isfield(totalDataStruct,nv.Key) % under this the source data has valid field
                val = totalDataStruct.(nv.Key);

                    [~, matchRows] =  isin(   val,   nv.Target.(nv.Key)    );
                    if numel(matchRows) >= 1 % here we should update this row by the new data
                        b_keyRowsFound = true;
                    else % here we should write to a new row
                        %b_keyRowsFound = false;
                    end
            else
                disp2(nv.Verbose,['Provided Key not found in source data structure' nv.Key ])
            end
            
        end
    end

    %% We have matchRows
    

     %% Fill the target from the source
     
     if b_keyRowsFound
        y = fillRows(Sources = totalDataStruct,Target=nv.Target,Rows=matchRows,Overwriting=nv.Overwriting,Verbose=nv.Verbose);
     end


 


end