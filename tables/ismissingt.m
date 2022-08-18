function y = ismissingt(x)
%ISEMPTYT Determines missing values in table or cells of a table
% Its specially designed to work with tables

[r,c] = size(x);
y = NaN(r,c);
for col = 1:c
    switch class(x(:,col))
        case 'table'      % this is fucking !!!
            switch class(x{:,col})
                case 'cell'
                     y(:,col) = cellfun(@isempty,x{:,col});
    
                otherwise
                     y(:,col) = ismissing(x{:,col});
            end
    
        case 'cell'
            y(:,col) = cellfun(@isempty,x(:,col));
    
        otherwise
            y(:,col) = ismissing(x);
    
    end
end




