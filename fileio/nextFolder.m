function [y] = nextFolder(path,levelsFrom)
%PREVIOUSFOLDER Find previous folder from path
%   levelsBack is how many subfolders you want to go back
pathparts = strsplit(path,filesep);
pathparts( cellfun(@isempty, pathparts)     )  = [];
Nparts = numel(pathparts);
if ~isempty(regexpi(pathparts{end},'\.\D+$')) % if .abc is found in the last part, it is assumed as file.
    Nparts = Nparts-1; 
end
y = pathparts{boundi(levelsFrom+1,Nparts)};

end

