function ylimoptimal(nv)
%YLIMOPTIMAL Summary of this function goes here
%   Detailed explanation goes here
arguments
    nv.PercentMargin = 0.1;
end

pYlim = nv.PercentMargin;

% xlim_orig=get(gca,'xlim');
% xw=xlim_orig(2)-xlim_orig(1);
% dxlim=[-xw*pXlim xw*pXlim]; % +pXlim% 
% xlim_wide=xlim_orig+dxlim;

ylim_orig=get(gca,'ylim');
yw=ylim_orig(2)-ylim_orig(1);
dylim=[-yw*pYlim yw*pYlim]; % +pXlim% 
ylim_wide=ylim_orig+dylim;

set(gca,'ylim',ylim_wide);
% axis([xlim_wide ylim_wide]); 




end

