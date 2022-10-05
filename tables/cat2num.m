function y = cat2num(var,catName,catNum)
%CAT2NUM Summary of this function goes here
%   Detailed explanation goes here
arguments
    var
end

arguments (Repeating)
    catName
    catNum

end

N = numel(catName);

var = reordercats(var,catName);

var= double(var);

l = false(numel(var),N);
for i=1:N
    l(:,i) = var == i;
end

for i=1:N
   var(  l(:,i)  )  = catNum{i};
end

y = var;
end

