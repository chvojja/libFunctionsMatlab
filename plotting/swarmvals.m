function h = swarmvals(varargin)
%SCATTERVALS Scatters arguments next to eachother


for i=1:nargin
    
    xnow = varargin{i}; xnow = xnow(:);

    swarmchart(i*ones(numel(xnow),1),xnow); hold on; 


end

h = gca;
end

