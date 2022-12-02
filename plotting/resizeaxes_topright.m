function resizeaxes_topright(varargin)
%RESIZEAXES_TOPRIGHT
% top right point is the anchor

switch nargin
    case 1
        resizeaxes_gca( varargin{1} );
    case 2
        axesfun( varargin{1} ,  @(x)resizeaxes_gca( varargin{2} ) ); 
end



function resizeaxes_gca(wh)
    if ~any(isnan(wh))
        ha=gca;

        % launch specific resize code
        lb_adjust = (ha.InnerPosition(3:4)-wh);
        ha.InnerPosition(1:2) = ha.InnerPosition(1:2) + lb_adjust;
        ha.InnerPosition(3:4) = wh;

        %
    end

end
end

