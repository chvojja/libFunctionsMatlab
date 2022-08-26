function [varargout] = dealsome(x,nv)
%DEALSOME Distributes inputs to up to 100 outputs which some of them may end up as empty.
arguments
    x;
    nv.MissingValue =-4;
end


switch class(x)
    case 'cell'
        if ~isempty(x{1})
            if nv.MissingValue == -4
                nv.MissingValue = val2nan(x{1}); % infer it from thefirst value
            end
            varargout=cell(100,1); 
            varargout(:) = {nv.MissingValue};
    
            for i=1:numel(x)
                 varargout{i} = x{i};
            end
        end

end
end

