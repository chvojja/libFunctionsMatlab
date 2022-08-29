function y = VKJ_eegFileName2lblFileName(eegFileName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y = [ eegFileName(1:end-4) '-lbl.mat'];
end

