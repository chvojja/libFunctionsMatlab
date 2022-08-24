function y = fillRowNew(nv)
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
        nv.Sources = []; % struct or table row or cell array of either struct or table row 
        nv.Source = []; % even element cell array of Key-Value pairs
        nv.Target table;
        nv.Overwriting = false;
        nv.Verbose = false;
    end

%         %% Prepare data
%        totalDataStruct = fields2struct(nv.Sources);   

    %% Get row
    [rowNumber, nv.Target] = nextRow(Table = nv.Target);

    % We have rowNumbers
    
    % Updateing Target from Sources
    y = fillRows(Source = nv.Source, Sources = nv.Sources,Target=nv.Target,Rows=rowNumber,Overwriting=nv.Overwriting,Verbose=nv.Verbose);
            
     


end