function s = scatterbetter(varargin)
%SWARMCHARTBETTER Summary of this function goes here
%   Detailed explanation goes here


s = scatter(varargin{:} ); % ,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5  );
%colormap(gca,'hsv')
s.MarkerFaceColor = 'k';
xlabel([]);
ylabel([]);


end

