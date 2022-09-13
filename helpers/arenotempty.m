function y  = arenotempty(varargin)
%ARENOTEMPTY Summary of this function goes here
%   Detailed explanation goes here
y = ~cellfun(@isempty,varargin);
end

