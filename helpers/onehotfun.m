function y = onehotfun(xC,valsC)

onehotL = cellfun(@isempty,xC)  ;
y = valsC{~onehotL};
end

