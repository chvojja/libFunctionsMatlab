function [s,Nsignal] = centersig(nv)
%CROPFILLMEAN Summary of this function goes here
% unfinished
arguments
    nv.Signal;
    nv.AroundIndex=[];
    nv.ByPercent=[];
    nv.FillBy=[];
end


Nsamples = numel(nv.Signal);

if ~isempty(nv.AroundIndex)
    around_ind = nv.AroundIndex;
    width_ind = min(nv.AroundIndex-1,Nsamples-nv.AroundIndex);
end   





if ~isempty(nv.FillBy)
    %s = NaN(size(nv.Signal));

else
    s = nv.Signal(  (around_ind-width_ind):(around_ind+width_ind) );
    Nsignal = numel(s);
end