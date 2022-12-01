function y = readcellstr(varargin)
%READTABLERAW Summary of this function goes here
%   Detailed explanation goes here
% opts = detectImportOptions(fpname);
% opts.DataRange = 'A1';
y = readcell(varargin{:},'DataRange','A1');

% turn missings into {''}
missing_value = '';
mask = cellfun(@(x) any(isa(x,'missing')), y); 
y(mask) = {missing_value};

% convert numbers o chars
y = cellfun(@num2str, y, 'UniformOutput', false);
end

