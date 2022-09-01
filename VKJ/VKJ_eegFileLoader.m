function [s,channels,fs,rangeDn] = VKJ_eegFileLoader(filename)
%VKJ_EEGFILELOADER Summary of this function goes here
%   Detailed explanation goes here
l = load(char(filename));
fs=l.fs;
s = l.s';
channels = l.chanNames;
rangeDn(1) = l.dateN;

clear l;


end

