function [y] = previousFolder(path,levelsBack)
%PREVIOUSFOLDER Find previous folder from path
%   levelsBack is how many subfolders you want to go back
pathparts = strsplit(path,filesep);
Nparts = numel(pathparts);
if ~isempty(regexpi(pathparts{end},'\.\D+$')) % if .abc is found in the last part, it is assumed as file.
    desiredLevelsUp = Nparts-levelsBack-1; 
else
    desiredLevelsUp = Nparts-levelsBack;
end
y = pathparts{boundi(desiredLevelsUp,Nparts)};

end

