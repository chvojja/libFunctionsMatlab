function [y] = previousPath(path,levelsBack)
%PREVIOUSFOLDER Makes the path shorter by a few folders
%   levelsBack is how many subfolders you want to go back
% works also with paths including a file

pathparts = strsplit(path,filesep);
Nparts = numel(pathparts);
if ~isempty(regexpi(pathparts{end},'\.\D+$')) % if .abc is found in the last part, it is assumed as file.
    pathparts(end)=[]; % delete file
    Nparts = numel(pathparts);
end

levelsBack = bound(levelsBack, 0, Nparts -1);
idxsToRemove =  (Nparts - levelsBack +1):(Nparts); % first it wil be N+1:N which gives empty so its fine
pathparts(idxsToRemove) =[];
y = fullfile(pathparts{:});

end

