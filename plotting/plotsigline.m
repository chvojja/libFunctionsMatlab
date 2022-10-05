function plotsigline(pvalue,x12,y,nv)
%SIGNIFICANCE Plot significance line above bar graph

% x12 = [ 1 2]
% y is height or datapoints

arguments
    pvalue
    x12
    y
    nv.BracketHeigth = 0.2;
    nv.TextMargin = 0.2;
    nv.NameValueArgs ={'-k', 'LineWidth', 2};
    nv.PlotPvalueNotStar = false;
end

plevels = [0.05 0.01 0.001];

% plot stars
if pvalue<plevels(1)
    if numel(y)>1, y = max(max(y)); end;
 
    ls = '*';
    lblpvalue = [ 'p < ' num2str(plevels(1))];
    if pvalue<plevels(2)
        ls = '**';
        lblpvalue = [ 'p < ' num2str(plevels(2))];
    elseif pvalue<plevels(3)
        ls = '***';
        lblpvalue = [ 'p < ' num2str(plevels(3))];
    end

    % Now plot the sig line on the current axis
    hold on
    
    hf = gcf; ha = gca;
    %if strcmp(hf.Units, 'centimeters')
       yAxSize = hf.Position(4);
       yInDataUnits = abs(diff(ha.YLim)) *nv.BracketHeigth/yAxSize;
      % If you want also to draw in x direction 
      % xAxSize = hf.Position(3);
       %xInDataUnits = abs(diff(ha.XLim)) *nv.TextMargin/xAxSize;

    y = y+   3*yInDataUnits;
    
    yBracketLow = y-yInDataUnits/2; yBracketHigh = y+yInDataUnits/2;
    yTextStar = y+1*yInDataUnits;
    yTextP= y+1.8*yInDataUnits;
    
    plot(x12,[1;1]*yBracketHigh, nv.NameValueArgs{:});%line
    

    
    
    %plot(mean(x12) , yTextStar, ls)% the sig star sign
    switch nv.PlotPvalueNotStar
        case true
             text(mean(x12), yTextP, lblpvalue,'HorizontalAlignment','center'); % the sig star sign
        case false
             text(mean(x12), yTextStar, ls,'FontSize',ha.FontSize*1.9,'HorizontalAlignment','center'); % the sig star sign
    end

    
    
    plot([1;1]*x12(1),[yBracketLow , yBracketHigh],nv.NameValueArgs{:} );%left edge drop
    plot([1;1]*x12(2),[yBracketLow , yBracketHigh],nv.NameValueArgs{:});%right edge drop

end

end

