function y = ismissingt(T)
%ISEMPTYT Determines missing values in table or cells of a table
% Its specially designed to work with tables
% Beware ! Logicals can not have NaNs so all columns of logicals are skipped and treated as empty even if not!!!

[r,c] = size(T);
y = NaN(r,c);

% class_T = class(T);
% 
% switch class_T
% 
%     case 'table'
% 
%             for col = 1:c
%                 switch class(T{:,col})
% 
%                     case 'cell'
%                         y(:,col) = cellfun(@isempty,T{:,col});
%             
%                     case 'logical'
%                         y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
%                 
%                     otherwise
%                         y(:,col) = ismissing(T{:,col});
%                 end
%             end
% 
%     otherwise % or its just a single element
% 
%             for col = 1:c
%                 switch class(T{:,col})
% 
%                     case 'cell'
%                         y(:,col) = cellfun(@isempty,T{:,col});
%             
%                     case 'logical'
%                         y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
%                 
%                     otherwise
%                         y(:,col) = ismissing(T{:,col});
%                 end
%             end
% end
% 
% end


for col = 1:c
    switch class(T(:,col))
        case 'table'      % this is fucking !!!
            switch class(T{:,col})
                case 'cell'
                     y(:,col) = cellfun(@isempty,T{:,col});
                case 'logical'
                        y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
                otherwise
                     y(:,col) = ismissing(T{:,col});
            end
    
        case 'cell'
            y(:,col) = cellfun(@isempty,T(:,col));
    
        case 'logical'
            y(:,col) = ones(r,1); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% !!!!!!!!!!!!!!!!!!!!!!!
    
        otherwise
            y(:,col) = ismissing(T(:,col));
    
    end
end





