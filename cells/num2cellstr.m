function y = num2cellstr(x)
%putnumeric array as cell array of strings
y = arrayfun(@num2str, x, 'UniformOutput', 0);