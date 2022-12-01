function squareaxis(axesHandles)
%SQUAREAXIS Summary of this function goes here
%   Detailed explanation goes here
switch nargin
    case 0

        %figureHandle=gcf;
        figureHandle=get(groot,'CurrentFigure');
        axesHandles = findobj(get(figureHandle,'Children'), 'flat','Type','axes');
        axis(axesHandles,'square');
        %axis('square');

    case 1

      axis(axesHandles,'square');



end



end

