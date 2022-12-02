function resizeaxes_center(varargin)
%RESIZEAXES_CENTER


switch nargin
    case 1
        resizeaxes_gca( varargin{1} );
    case 2
        axesfun( varargin{1} ,  @(x)resizeaxes_gca( varargin{2} ) ); 
end



function resizeaxes_gca(wh)

        ha=gca;
% 
%         % launch specific resize code
%         lb_adjust = (ha.InnerPosition(3:4)-wh)/2;
%         ha.InnerPosition(1:2) = ha.InnerPosition(1:2) + lb_adjust;
%         ha.InnerPosition(3:4) = wh;

%       %w
        if ~isnan(wh(1))
            adjust = (ha.InnerPosition(3)-wh(1))/2;
            ha.InnerPosition(1) = ha.InnerPosition(1) + adjust;
            ha.InnerPosition(3) = wh(1);
        end

        % h
        if ~isnan(wh(2))
            adjust = (ha.InnerPosition(4)-wh(2))/2;
            ha.InnerPosition(2) = ha.InnerPosition(2) + adjust;
            ha.InnerPosition(4) = wh(2);
        end

    end


end

