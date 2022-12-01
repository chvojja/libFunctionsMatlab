function trueblackaxis(axes_handles)
%TRUEBLACKAXIS Summary of this function goes here
%   Detailed explanation goes here

arguments 
    axes_handles = gca;
end

desired_color = [0 0 0];

axes_handles.ZColor = desired_color;
axes_handles.YColor = desired_color;
axes_handles.XColor = desired_color;

end







