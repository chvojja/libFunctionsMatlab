function [Touter,ilefts] = leftjoinsorted(varargin)
%LEFTJOINSORTED Left Join that keep original order of Tleft



[Touter,ileft,iright] = outerjoin(varargin{:}, 'Type','Left');
[ilefts, sortinds] = sort(ileft);
Touter = Touter(sortinds,:);




end

