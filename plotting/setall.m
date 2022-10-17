function setall(varargin)
%SETALL Changes property of everything

for i = nargin/2
    hf = findobj(gcf, '-property', 'FontSize'); set(hf,{varargin{i*2-1}}, num2cell( varargin{i*2} ));
end

end

