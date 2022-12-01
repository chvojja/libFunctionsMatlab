function h = scattervals(varargin)
%SCATTERVALS Scatters arguments next to eachother

start_ind = 1;
for i=1:nargin
    
    xnow = varargin{i}; xnow = xnow(:);
    end_ind = start_ind-1+numel(xnow);

    scatter(start_ind: end_ind, xnow); hold on;
    start_ind=end_ind+1;

end

h = gca;

end

