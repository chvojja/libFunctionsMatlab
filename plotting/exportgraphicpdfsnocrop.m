function  exportgraphicpdfsnocrop(varargin)
%EXPORTGRAPHICSNOCROP Favourite printing function

annotation('rectangle',[0 0 1 1],'Color','w'); % to no crop
if isempty(varargin)
   exportgraphics(gcf, 'kokoti.pdf','BackgroundColor', 'none','ContentType','vector');
else
   exportgraphics(varargin{:},'BackgroundColor', 'none','ContentType','vector');
end

end

