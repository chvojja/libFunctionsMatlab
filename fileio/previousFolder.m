function [y] = previousFolder(path,levelsBack)
%PREVIOUSFOLDER Find previous folder from path
%   levelsBack is how many subfolders you want to go back
pathparts = strsplit(path,filesep);
Nparts = numel(pathparts);
if ~isempty(regexpi(pathparts{end},'\.\D+$')) % if .abc is found in the last part, it is assumed as file.
    desiredLevelsBack = Nparts-levelsBack-1; 
else
    desiredLevelsBack = Nparts-levelsBack;
end
y = pathparts{boundi(desiredLevelsBack,Nparts)};

end

