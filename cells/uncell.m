function x = uncell(x)
%UNCELL Unnests a cell if necessary
if iscell(x)
    x = x{:};
end

