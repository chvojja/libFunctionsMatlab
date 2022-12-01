function ylimfromzero()
%YLIMFROMZERO Summary of this function goes here
%   Detailed explanation goes here
ylim = get(gca,'YLim'); ylim(1) = 0;
set(gca,'YLim', ylim );
end

