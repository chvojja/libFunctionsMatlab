function y = table_fillRowByFields(nv)
% This pulls data from DataStructure and puts them to same-named columns  of a table at row Row
% ID of the new row is updated only if at least one column of the row is modified
arguments
    nv.Table table;
    nv.Row double; 
    nv.DataStructure struct;
end

dataStructure = nv.DataStructure;
fields = fieldnames(dataStructure);

for kf = 1:numel(fields)
     fieldName = fields{kf};
    
     if any(strcmp(fieldName,nv.Table.Properties.VariableNames)) && ~isempty(dataStructure.(fieldName))
         nv.Table.(fieldName)(nv.Row) = dataStructure.(fieldName);

     end

end

y = nv.Table;

