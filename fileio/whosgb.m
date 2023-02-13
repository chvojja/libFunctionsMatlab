function size_GB = whosgb(x)
%WHOSGB Summary of this function goes here
%   Detailed explanation goes here
wt = evalin("base",['whos(''' x ''');']);

% wt.gbytes=wt.bytes/1024/1024/1024

size_GB = wt.bytes/1024/1024/1024;
disp(['Size of the variable is: ' num2str(wt.bytes/1024/1024/1024) ' GBytes or '  num2str(wt.bytes/1024/1024) ' MBytes.']);

end

