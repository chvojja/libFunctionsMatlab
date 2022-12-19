function ypd = pdfsplitmix(gm,x)
%PDFSPLITGM Summary of this function goes here
%   Detailed explanation goes here

x = x(:);
Nc = gm.NumComponents;
Nr = length(x);
ypd = zeros(Nr,Nc);


for i = 1:Nc
    gmg_mixing_proportion = gm.ComponentProportion(i);
    gmg = gmdistribution(gm.mu(i),gm.Sigma(i));
    ypd(:,i)  = gmg_mixing_proportion*pdf(gmg,x);
    
end
