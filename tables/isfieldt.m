function y = isfieldt(table,fieldName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y = ismember(fieldName, table.Properties.VariableNames);
end

