function y = ismissingt(T)
%ISMISSINGT Determines missing values in table or cells of a table
% Its specially designed to work with tables
% Beware ! Logicals can not have NaNs so all columns of logicals are skipped and returned as NaN
% Int = 0 is considered as missing value.

[r,c] = size(T);
y = NaN(r,c);

for col = 1:c
    switch class(T(:,col))
        case 'table'      % this is fucking !!!
            switch class(T{:,col})
                case 'cell'
                     y(:,col) = cellfun(@isempty,T{:,col});
                case 'logical'
                        %y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
                case {'int8','int16' ,'int32' ,'int64' }  
                    y(:,col) = T{:,col} == 0;    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
                otherwise
                     y(:,col) = ismissing(T{:,col});
            end
    
        case 'cell'
            y(:,col) = cellfun(@isempty,T(:,col));

        case {'int8','int16' ,'int32' ,'int64' }  
            y(:,col) = T(:,col) == 0;  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!! 

        case 'logical'
            %y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
    
        otherwise
            y(:,col) = ismissing(T(:,col));
    
    end
end





