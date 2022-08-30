function y = filterByValues(nv)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
arguments
    nv.Table;
    nv.FieldValuePairs = [];
    nv.BetweenPairsFun = @or; % @and
end

if ~isempty(nv.FieldValuePairs)
    filterColumnValuePairs = vec2pairs(nv.FieldValuePairs);
    filterL = false(size(nv.Table,1),1);
    for ip = 1:size(filterColumnValuePairs,1)
        colName = filterColumnValuePairs{ip,1};
        colVal= filterColumnValuePairs{ip,2};
        ifilterL = ismember( nv.Table.(colName) , colVal );
        filterL = nv.BetweenPairsFun( ifilterL, filterL );
    end
    y = nv.Table(filterL,:);
else
    y = nv.Table;
end


end

