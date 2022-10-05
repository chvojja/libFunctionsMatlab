function [y1,y2] = splitpath( nv )
%SPLITPATH Summary of this function goes here
%   Detailed explanation goes here
arguments 
    nv.FilePath;
    nv.SplitByLastFew=[];
    nv.SplitByFirstFew=[];
end
    
pathparts = strsplit(nv.FilePath,filesep);

if ~isempty(nv.SplitByLastFew)
    y1 = fullfile( pathparts{1:end-nv.SplitByLastFew} );
    y2 = fullfile( pathparts{end-nv.SplitByLastFew+1:end} );
end

if ~isempty(nv.SplitByFirstFew)
    y1 = fullfile( pathparts{1:nv.SplitByFirstFew} );
    y2 = fullfile( pathparts{nv.SplitByFirstFew+1:end} );
end

end

