function [rowNumber,Tupdated] = nextRow(nv)
%ROWNUMBER Finds next free row of a table and if a new row has to be added,
% it adds it and return an updated table
arguments 
    nv.Table table
    nv.Key = 'ID';
%     nv.ID = [];
end

[r,c] = size(nv.Table);
rowNumber = r+1;


if isempty(nv.Key) % We search for missing values in all columns
    missingL = ismissingt(nv.Table); 
    missingL(isnan(missingL))=1;
    rowsAllFree = find(~any(~missingL'));
    if ~isempty(rowsAllFree)
        rowNumber = rowsAllFree(1);
    end
else % If KeyColumn provided, we know where to search
    isu = find(ismissing(nv.Table.(nv.Key))); 
    if ~isempty(isu)
        rowNumber = isu(1);
    end
end


if rowNumber > r % if we need to add a row of a table
    newRow = nv.Table(end,:);
    for iCol=1:c
        newRow{1,iCol} = val2missingt(newRow{1,iCol});
    end
    Tupdated = [nv.Table ; newRow];
else
    Tupdated = nv.Table;
end

% 
% arguments 
%     nv.Table table
%     nv.Key = [];
% end
% 
% [r,c] = size(nv.Table);
% rowNumber = r+1;
% 
% if isempty(nv.Key) % We search for missing values in all columns
%     missingL = ismissingt(nv.Table); 
%     missingL(isnan(missingL))=1;
%     rowsAllFree = find(~any(~missingL'));
%     if ~isempty(rowsAllFree)
%         rowNumber = rowsAllFree(1);
%     end
% else % If KeyColumn provided, we know where to search
%     isu = find(ismissing(nv.Table.(nv.Key))); 
%     if ~isempty(isu)
%         rowNumber = isu(1);
%     end
% end
% 
% 
% if rowNumber > r % if we need to add a row of a table
%     newRow = nv.Table(end,:);
%     for iCol=1:c
%         newRow{1,iCol} = val2missingt(newRow{1,iCol});
%     end
%     Tupdated = [nv.Table ; newRow];
% else
%     Tupdated = nv.Table;
% end
