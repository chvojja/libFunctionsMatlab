function h = plotstockwell(s,fs,timeres,frange,Nfreqpoints,type)

absX=abs( stockwell(s,fs,timeres,frange) );

tmax = length(s);

[Nf,Ns] = size(absX);

x = linspace(0,tmax, Ns );
y = 1:Nf;
[X,Y] = meshgrid(x,y);
Z = absX;


switch type
    case 'log'

        h = surf(X,Y,flipud(Z), 'edgecolor', 'none'); set(gca, 'YScale', 'log');
        view(0,90);
        yticklabels =(    round(linspace(frange(1),frange(2),Nfreqpoints),0 )    );

    case 'linear'
        h = imagesc(absX);
yticklabels = fliplr(    round(linspace(frange(1),frange(2),Nfreqpoints),0 )    );

end

        
        yticks = linspace(1, size(absX, 1), numel(yticklabels));
        set(gca, 'YTick', yticks, 'YTickLabel', (yticklabels(:)));


%  h = controurf(X,Y,flipud(Z), 'LineColor','none' );
% set(gca, 'YScale', 'log')
% 
% plot3(X,Y,Z)
% 
% line([X,X], [Y,Y], [Z,Z], 'LineStyle','none', 'Marker','o', 'Color','b',)
% view(3)
% 
% h = pcolor(X,log10(Y+1),Z);
% h.EdgeColor = 'none';




% %plotalone spect

%  

end