function Y = table2empty(T,r)
%TABLE2EMPTY Summary of this function goes here
%   Detailed explanation goes here
arguments
    T;
    r = 1;
end

VariableTypes = varfun(@class,T,'OutputFormat','cell');
Y=table('Size',[r size(T,2)],'VariableNames',T.Properties.VariableNames,'VariableTypes',VariableTypes);


end

