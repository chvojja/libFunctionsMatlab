function setall(varargin) %prop_name,prop_value
%SETALL Changes property of everything

% arguments (Repeating)
%     prop_name
%     prop_value
% end

if mod(nargin,2)
    h = varargin{1};
    prop_name = varargin([ 2:2:(nargin-1)] );
    prop_value = varargin([ 3:2:(nargin)] );
else
    h = gcf;
    prop_name = varargin([ 1:2:(nargin-1)] );
    prop_value = varargin([ 2:2:(nargin)] );
end


for i = 1:numel(prop_name)
    %%hf = findobj(gcf, '-property', varargin{i*2-1}); 
    hf = findall(h, '-property', prop_name{i}); 
    set(hf,{prop_name{i}}, { prop_value{i} });
end

end



% function setall(varargin)
% %SETALL Changes property of everything
% 
% for i = nargin/2
%     %%hf = findobj(gcf, '-property', varargin{i*2-1}); 
%     hf = findall(gcf, '-property', varargin{i*2-1}); 
%     set(hf,{varargin{i*2-1}}, { varargin{i*2} });
% end
% 
% end
% 
