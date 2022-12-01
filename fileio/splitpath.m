function [y1,y2] = splitpath(fpath, nv )
%SPLITPATH Summary of this function goes here
%   Detailed explanation goes here
arguments 
    fpath;
    nv.ByLastFew=[];
    nv.ByFirstFew=[];
    nv.ByFolder = [];
end
    
pathparts = strsplit(fpath,filesep);

if ~isempty(nv.ByLastFew)
    y1 = fullfile( pathparts{1:end-nv.SplitByLastFew} );
    y2 = fullfile( pathparts{end-nv.SplitByLastFew+1:end} );
end

if ~isempty(nv.ByFirstFew)
    y1 = fullfile( pathparts{1:nv.SplitByFirstFew} );
    y2 = fullfile( pathparts{nv.SplitByFirstFew+1:end} );
end

if ~isempty(nv.ByFolder)
    split_ind = find(matches(pathparts,nv.ByFolder));
    y1 = fullfile( pathparts{1:split_ind} );
    y2 = fullfile( pathparts{(split_ind+1):end} );
end

end

