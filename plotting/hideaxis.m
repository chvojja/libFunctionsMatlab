function hideaxis(hax)
%HIDEAXIS
% Suitable for scientific paper showing EEG
arguments
    hax = gca;
end

hax.XAxis.Visible = false;
hax.YAxis.Visible = false;


end

