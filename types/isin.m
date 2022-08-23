function [iL,iDx] = isin(val,B)
%ISIN Determine if val is in B

%class_B = class(B);

if iscell(B)
        iL = cellfun(@(x)isequaln(x,val),B);
        iDx= find(iL);
else
    if isnumeric(B) || iscategorical(B)
        iL = arrayfun(@(x)isequaln(x,val),B);
        iDx= find(iL);
    else
        return;
    end
end

% 
% cellfun(@ismember,aa)
% 
% varargout = ismember(varargin{:});
% 
% find(      );
% 
% switch class(B)
%     case 'cell'
%         iL = cellfun(@(x)isequaln(x,val),nv.Target.(nv.KeyColumn));
%         iDx= find(iL);
%     case 
%         
% 


