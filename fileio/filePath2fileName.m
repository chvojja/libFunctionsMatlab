function y = filePath2fileName(filePath)
%FILENAME Summary of this function goes here
%   Detailed explanation goes here
[~,fName,ext] =fileparts(filePath);
y = [fName ext]; 
end

