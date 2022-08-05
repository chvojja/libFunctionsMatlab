function y = table_fillRowByFields(pv)
% This pulls data from DataStructure and puts them to same-named columns  of a table at row Row
arguments
    pv.Table table;
    pv.Row double; 
    pv.DataStructure struct;
end

dataStructure = pv.DataStructure;
fields = fieldnames(dataStructure);

for kf = 1:numel(fields)
     fieldName = fields{kf};
    
     if any(strcmp(fieldName,pv.Table.Properties.VariableNames))
         pv.Table.(fieldName)(pv.Row) = dataStructure.(fieldName);

     end

end

y = pv.Table;

