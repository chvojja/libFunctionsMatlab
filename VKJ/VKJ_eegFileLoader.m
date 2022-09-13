function [s,channels,fs,fileInfo] = VKJ_eegFileLoader(eegFilePath)
%VKJ_EEGFILELOADER Summary of this function goes here
%   Detailed explanation goes here
l = load(char(eegFilePath));
fs=l.fs;
s = l.s';
channels = l.chanNames;
%rangeDn(1) = l.dateN;


fileInfo = VKJ_eegFileContent2FileInfo(l);


[~,eegFileName,ext] = fileparts(eegFilePath);
fileInfo.srcSigFile = [eegFileName ext];

clear l;


end

