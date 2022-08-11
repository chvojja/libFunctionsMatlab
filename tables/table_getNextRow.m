function y = table_getNextRow(nv)
% This looks on a table and finds nearest row number wher is NaN  or undefined field in a certain column
% column can be specified by name (string) or order (double)
arguments
    nv.Table table;
    nv.Column {string, double}; % name of the column
end

colName = nv.Column;


if iscategorical(nv.Table.(colName))
    isu = find(isundefined(nv.Table.(colName)));
    y = isu(1);
end
if isnumeric(nv.Table.(colName)) || islogical(nv.Table.(colName))
    % isz = find(~(pv.Table.(column)));
     isz = find(isnan(nv.Table.(colName)));
    y = isz(1);
end

