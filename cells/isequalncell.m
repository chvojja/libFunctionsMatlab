function y = isequalncell(x1,x2_cell)
%ISEQUALNCELL Summary of this function goes here
%   Detailed explanation goes here
y = cellfun(@(x)isequaln(x,x1),x2_cell);
end

