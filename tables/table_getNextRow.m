function y = table_getNextRow(pv)
% This looks on a table and finds nearest row number wher is NaN  or undefined field in a certain column
% column can be specified by name (string) or order (double)
arguments
    pv.Table table;
    pv.Column {string, double}; % name of the column
end

colName = pv.Column;


if iscategorical(pv.Table.(colName))
    isu = find(isundefined(pv.Table.(colName)));
    y = isu(1);
end
if isnumeric(pv.Table.(colName)) || islogical(pv.Table.(colName))
    % isz = find(~(pv.Table.(column)));
     isz = find(isnan(pv.Table.(colName)));
    y = isz(1);
end

