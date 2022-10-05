function T = rownames2var(T,varName)
%ROWNAMES2VAR Summary of this function goes here
%   Detailed explanation goes here
T=[  cell2table( T.Properties.RowNames ,"VariableNames",{varName} )   T   ];
end

