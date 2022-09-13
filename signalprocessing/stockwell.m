function [X,faxis] = stockwell(x,fs,tres,frange)
x = x(:);
dstfun = fdst(numel(x'),tres);

X=dstfun(x');

N=size(X,1);
Nfhigh=round(N*frange(2)/(fs/2));
Nflow=round(N*frange(1)/(fs/2));
if Nflow<1, Nflow = 1; end;
X=flipud(X(Nflow:Nfhigh,:)); % selected fmax and flipped so lowest are down
faxis = linspace(frange(1),frange(2),size(X,1));
% % margin=400;
% % absX=absX(:,margin:end-margin+1);
% 
% imagesc(absX);
% NfreqTicsk=12;
% yticklabels = round(linspace(0,f2,NfreqTicsk));
% yticks = linspace(1, Nfre, numel(yticklabels));
% set(gca, 'YTick', round(yticks), 'YTickLabel', flip(yticklabels(:)));
% set(gca,'XTick',[])
% ylabel('frequency, Hz');
