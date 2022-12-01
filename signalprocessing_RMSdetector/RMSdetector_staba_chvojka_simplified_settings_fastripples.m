% % FastRipples
% 
% n_std_rms=4.5;  %2.8
% freq_bounds = [250 900];
% rmsLen=3;
% join_gap=0.5; %2
% minAcceptLen=6;  %ms %4.5
% minPeaks = 13;
% 
% magnitude_FR = gaussmagbp([250 300 800 900],5000);
% filteringfun = @(x,x1)filterfft2(x,magnitude_FR);
% 
% peakPromRatio = 0.25;