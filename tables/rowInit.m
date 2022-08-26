function [T, rT] = rowInit(T,nv)
%ROWNUMBER Finds next free row of a table and if a new row has to be added,
% it adds it and return an updated table
arguments 
    T
    nv.Key = []; %'ID';
%     nv.ID = [];
end

[r,c] = size(T);

[b_hasID,nv.Key] = hasID(T,Key = nv.Key) ;

if b_hasID

    isu = find(ismissingt(T.(nv.Key)));
    if ~isempty(isu) 
        row = isu(1); % T has missing rows at the end
        

    else % A new row is needed

        newRow = T(end,:);
        for iCol=1:c
            newRow{1,iCol} = val2missingt(newRow{1,iCol});
        end
        T = [T ; newRow];

        row =  r+1;
    end
    id = newID(T);

else
    return
end

rT.row=row;
rT.id = id;

% 
% if isempty(nv.Key) % We search for missing values in all columns
%     missingL = ismissingt(T); 
%     missingL(isnan(missingL))=1;
%     rowsAllFree = find(~any(~missingL'));
%     if ~isempty(rowsAllFree)
%         row = rowsAllFree(1);
%     end
% else % If KeyColumn provided, we know where to search
%     isu = find(ismissing(T.(nv.Key))); 
%     if ~isempty(isu)
%         row = isu(1);
%     end
% end
% 
% 
% if row > r % if we need to add a row of a table
%     newRow = T(end,:);
%     for iCol=1:c
%         newRow{1,iCol} = val2missingt(newRow{1,iCol});
%     end
%     Tupdated = [T ; newRow];
% else
%     Tupdated = T;
% end

% 
% arguments 
%     T table
%     nv.Key = [];
% end
% 
% [r,c] = size(T);
% rowNumber = r+1;
% 
% if isempty(nv.Key) % We search for missing values in all columns
%     missingL = ismissingt(T); 
%     missingL(isnan(missingL))=1;
%     rowsAllFree = find(~any(~missingL'));
%     if ~isempty(rowsAllFree)
%         rowNumber = rowsAllFree(1);
%     end
% else % If KeyColumn provided, we know where to search
%     isu = find(ismissing(T.(nv.Key))); 
%     if ~isempty(isu)
%         rowNumber = isu(1);
%     end
% end
% 
% 
% if rowNumber > r % if we need to add a row of a table
%     newRow = T(end,:);
%     for iCol=1:c
%         newRow{1,iCol} = val2missingt(newRow{1,iCol});
%     end
%     Tupdated = [T ; newRow];
% else
%     Tupdated = T;
% end
