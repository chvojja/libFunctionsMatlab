function y = changePath(nv)
%CHANGEFILEPATH Needs to be implemented yet
arguments
    nv.Old;
    nv.New;
    nv.LevelsBack = [];
end
if isempty(nv.LevelsBack)
    y = fullfile( char(nv.New) , filePath2fileName(char(nv.Old)) );
else
    % implement here
end
end

