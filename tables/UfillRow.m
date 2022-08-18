function y = fillRow(nv)
% This pulls data from DataStructure and puts them to same-named columns  of a table at row Row
% ID of the new row is updated only if at least one column of the row is modified
% If Key variable is set, then it checks if the row with such key exists and if so,
% it does not overwrite it and does nothing
arguments
    nv.Destination table;
    nv.Row double = []; 
    nv.Key string = 'YourUniqueKey';
    nv.Source = [];  % nv.Table
end
dataStructure = nv.DataStructure;
fields = fieldnames(dataStructure);


% if ~strcmp(char(nv.Key),'YourUniqueKey')
%     nv.Table.Key
% end

% if isempty(nv.Row)
%     nv.Row = table_getNextRow(Table = nv.Table, Column = 'ID'); 
% end


for kf = 1:numel(fields)
     fieldName = fields{kf};
    
     if any(strcmp(fieldName,nv.Table.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
         nv.Table.(fieldName)(nv.Row) = dataStructure.(fieldName);

     end

end

y = nv.Table;

