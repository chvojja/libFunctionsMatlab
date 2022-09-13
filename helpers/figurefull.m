function h = figurefull(varargin)
%FIGUREFULL A figure() wrapper that makes it fullscreen and white by default

%h = figure('Units','normalized','OuterPosition',[0 0 1 1],varargin{:});

h = figure('Color','white',varargin{:});
h.WindowState = 'maximized';
end

