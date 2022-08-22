function rowNumber = nextRow(nv)
%ROWNUMBER Finds next free row of a table 
arguments 
    nv.Table table
    nv.KeyColumn = [];
end

rowNumber = size(nv.Table,1)+1;

if isempty(nv.KeyColumn) % We search for missing values in all columns
    missingL = ismissingt(nv.Table); 
    rowsAllFree = find(~any(~missingL'));
    if ~isempty(rowsAllFre)
        rowNumber = rowsAllFree(1);
    end
else % If KeyColumn provided, we know where to search
    isu = find(ismissing(nv.Table.(nv.KeyColumn))); 
    if ~isempty(isu)
        rowNumber = isu(1);
    end
end

