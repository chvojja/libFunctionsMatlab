function y = table_rowfun(pv)
% This applies a function to all rows of a table that does have a valid ID
% ID column is supposed to be the first column
arguments
    pv.Table table;
    pv.Function function_handle; % name of the function
end

Nrows = table_getNextRow(Table = pv.Table, Column = 1);  % ID column is supposed to be the first column
Nrows = Nrows -1;

for row = 1:Nrows
    pv.Table(row,:) = pv.Function(pv.Table(row,:));
end

y = pv.Table;

