function [mean_measure,var_measure] = multimodalstats(x,ngaussians,units)
%MULTIMODALMED Returns
%%
arguments
    x
    ngaussians
    units ='std'
end


% testdata
% Ns = 1000;
% % x = randn(Ns,1);
% % xz = zeros(Ns,1);
% 
% mu1 = [0];
% Sigma1 = [2 ];
% mu2 = [-1];
% Sigma2 = [0.2];
% rng(1); % For reproducibility
% x = [mvnrnd(mu1,Sigma1,Ns/2); mvnrnd(mu2,Sigma2,Ns/2)];
% 
% %swarmchart(xz,x);

GMModel = fitgmdist(x,ngaussians);
mean_measure = GMModel.mu;


switch units

    case 'std'

        % gm_mu = GMModel.mu;
         var_measure = sqrt(GMModel.Sigma(:)); 

    case 'sem'
        %x_sort = sort(x,'ascend');
        Ns = 1000; % precision of the calculation
        xz0 = linspace(min(x),max(x),Ns)';
        ypd = pdfsplitmix(GMModel,xz0);
        % jednodussi varianta
%         p = pdf('Normal', x, gmmu(1), gmsigma(1)^0.5); % nebo sqrt??
%         q = pdf('Normal', x, gmmu(2), gmsigma(2)^0.5);
        
%          gmPDF = @(x) arrayfun(@(x0) pdf(GMModel,[x0 ]),x);
%          plot(xz0,gmPDF(xz0))
%         hold on;
%         %t = x_sort(1):1/1000:x_sort(end);
%         plot(xz0,ypd(:,1))
%         plot(xz0,ypd(:,2))
%         
        areas_like=sum(ypd);
        ar_total =sum(areas_like);
        N=length(x);
        
        sqrt_N=sqrt(   round(N*areas_like./ar_total)   );
        var_measure = sqrt(GMModel.Sigma(:))./sqrt_N';  % column
end


% sort

[mean_measure,var_measure ]= sort2(mean_measure,var_measure);


% arear_under_crve = @(amp) integral(@(x)gauss(x,amp),8.5,17);
% then: 
% amp = fsolve(@(amp) arear_under_crve(amp) - 30000, 1)

% plot(gaussian(-20:1/100:20,0,1))

% 
% gscatter(x,xz,idx,'rb','+o');
% scatter(xz,x,idx,'rb');
% 
% idx = cluster(GMModel,x);

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

end



end

