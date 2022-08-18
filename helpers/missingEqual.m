function y = missingEqual(left,right)
%MISSINGSAME simplification of comparing two values
%   Self explanatory...

b_l = ismissing(left);
b_r = ismissing(right);
 
y.equal = ~b_l && ~b_r && isequal(left,right); % if one of them  is missing, they are ultimately different
y.different =  ~b_l && ~b_r && ~isequal(left,right);

y.missing.left = b_l;
y.having.left = ~b_l;
y.missing.right = b_r;
y.having.right = ~b_r;
y.missing.both = b_l && b_r;
y.having.both = ~b_l && ~b_r;

end

