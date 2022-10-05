function varargout = tablegroups2num(T,groupVarName)
%TABLEGROUPS2NUM translates a table grouping into a matrix of values 
% T has a groupVarName variable that is numeric, thus we can order it
% T is expected to have two columns

varNames = T.Properties.VariableNames;
yvarName = setdiff(varNames,groupVarName);
yvarName = yvarName{1};

groupValsSorted = unique(T.(groupVarName),'sorted');

Ng = numel(groupValsSorted);
varargout = cell(Ng,1);
for i = 1: Ng
    varargout{i} = T.(yvarName)(  T.(groupVarName) == groupValsSorted(i)  );
end



end

