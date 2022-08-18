function y = table_fillNewRowByFields(nv)
%TABLE_FILLNEWROWBYVALUES Finds first empty row (with ID field having NaN)
% and pulls data from DataStructure and puts them to same-named columns  of a table at row Row.
% ID of the new row is updated only if at least one column of the row is written

arguments
    nv.Table table;    % first column is expected to be named 'ID'
    nv.DataStructure struct;
end

row = table_getNextRow(Table = nv.Table, Column = 'ID'); 


dataStructure = nv.DataStructure;
fields = fieldnames(dataStructure);

for kf = 1:numel(fields)
     fieldName = fields{kf};
    
     if any(strcmp(fieldName,nv.Table.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
         nv.Table.(fieldName)(row) = dataStructure.(fieldName);
         nv.Table.ID(row) = row; 

     end

end

y = nv.Table;

