function s = swarmchartbetter(varargin)
%SWARMCHARTBETTER Summary of this function goes here
%   Detailed explanation goes here


s = swarmchart(varargin{:} ); % ,'MarkerFaceAlpha',0.5,'MarkerEdgeAlpha',0.5  );
s.SizeData = 1;
%colormap(gca,'hsv')
s.MarkerFaceColor = 'k';
s.XJitterWidth = 0.5;
xlabel([]);
ylabel([]);


end

