function scientificfontcompact(axes_handles,ratio)
%FONTS Summary of this function goes here
%   Detailed explanation goes here
arguments 
    axes_handles = gca;
    ratio = 0.7;
end

hax = axes_handles; % works for one axes so far



ax_name = 'XAxis';
process_axis(hax,ax_name,ratio);
ax_name = 'YAxis';
process_axis(hax,ax_name,ratio);



function process_axis(hax,ax_name,ratio)
    fs = hax.(ax_name).FontSize;
    fs_subsrcipt = fs*ratio;
    for i=1:numel(hax.(ax_name).TickLabels)
        % works only for tex interpreter
        label_text = hax.(ax_name).TickLabels{i};
        pos_of_superscript = regexp(  label_text  , '\^\{\-*\d+\}' );  % ending with  =  dollar sign
        if ~isempty(pos_of_superscript)
            hax.(ax_name).TickLabels{i} = [label_text(1:(pos_of_superscript-1))  '\fontsize{' num2str(fs_subsrcipt) '}'  label_text(pos_of_superscript:end) ];
        end
    end

end



end

