function y_struct = cell2namedargs(x_cell)
%CELL2NAMEDARGS Converts a cell array with even number of cells into a name value paired structure

Nc=numel(x_cell);
if (    even(Nc) && ~isempty(x_cell)   )
   Nch=Nc/2;
   for i = 1:Nch
       y_struct.(x_cell{2*i-1}) = x_cell{2*i};
   end

else
    y_struct = [];

end
