function y = charArgs2cell(chArgs)
%CHARARGS2CELL Summary of this function goes here
%   Detailed explanation goes here
y = split(chArgs,{' ',',',';'});  % {' ','  ','   ',',',', ',',  ',';','; ',';  '});
y = y(~cellfun(@isempty,y) );
end

