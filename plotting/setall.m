function setall(varargin)
%SETALL Changes property of everything

for i = nargin/2
    %%hf = findobj(gcf, '-property', varargin{i*2-1}); 
    hf = findall(gcf, '-property', varargin{i*2-1}); 
    set(hf,{varargin{i*2-1}}, { varargin{i*2} });
end

end

