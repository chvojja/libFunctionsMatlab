function axesfun(axes_array,fun_handle)
%AXESFUN Summary of this function goes here
%   Detailed explanation goes here
Na = numel(axes_array);
for i = 1:Na
    axes(axes_array(i));
    fun_handle();
end


end

