function [y] = subFolders(nv)
%SUBFOLDERS Returns subfolders as cell array from counting from zeros or specified root folder to the last folder where the file is.
arguments
    nv.FilePath {char, string} ;
    nv.Offset {char, string, double}  = 0; % offset is specified by ns
end

pathparts = strsplit(nv.FilePath,filesep);
Nparts = numel(pathparts);


if isempty(regexpi(pathparts{end},'\.\D+$')) % if .abc is found in the last part, it is assumed as file.
    disp('Error, the path is not a file path but a directory.') 
else

    if isempty(regexpi(pathparts{end},'D\\'))
        driveOffset = 1;
    else 
        driveOffset = 0;
    end
    
if ~isnumeric(nv.Offset)

    offparts = strsplit(nv.Offset,filesep);
    nv.Offset = offparts{end};
    nv.Offset = find(isequalncell(nv.Offset,pathparts)) - 1;
end    
y = pathparts(boundi(nv.Offset+1+driveOffset,Nparts):end-1);


end

