function varargout = uncell(x)
%UNCELL Unnests a cell if necessary
if iscell(x)
    varargout = { x{:} };   
else
    varargout{1} = x;
end

