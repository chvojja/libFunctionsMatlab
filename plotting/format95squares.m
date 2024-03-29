function format95squares()
%FORMAT95SQUARES 
% Suitable for Brain 
% width is 95mm
% all is true black
% all axes are square
% all fonts are Arial 7

width_mm = 23.63;
hax = gca;

% backup tics and labels
XTick = hax.XTick;
XTickLabel = hax.XTickLabel;
YTick = hax.YTick;
YTickLabel = hax.YTickLabel;


trueblackaxis(hax);
squareaxis(hax);

 
% set font name and line width globally
setall('FontName','Arial');
setall('LineWidth',0.4);

% set font size only in the axis

hax.FontSize = 7; % premeks favourite
hax.LabelFontSizeMultiplier = 1; % prevent font size from changing



% restore
% hax.XTick = XTick ;
% hax.XTickLabel = XTickLabel;
% hax.YTick = YTick;
% hax.YTickLabel = YTickLabel;

% % freeze labels and ticks
% hax.XTickMode='manual';
% hax.XTickLabelMode='manual';
% 
% hax.YTickMode='manual';
% hax.YTickLabelMode='manual';


scientificfontcompact(hax);

% % resize
% resize2cm(9.5,8);





% % set length of ticks
% set(hax, 'Units', 'centimeters');
% pos = get(gca,'Position');
% height_cm = pos(4);
% desired_length = 0.05; %cm
% normalized_length = desired_length./height_cm;
% set(gca,'TickLength', [normalized_length, 0.01]);
% 
% 


% this does not work - it changes font////
% ax.XAxis.TickLabelInterpreter = 'latex';
% ax.YAxis.TickLabelInterpreter = 'latex';



% exportgraphics(gcf, 'kokoti.pdf','ContentType','vector')

end

