function y = vec2pairs(x_2NRowOrColumn)
%CELL2CELLPAIRS Reshapes a vector to pairs with two columns
N = numel(x_2NRowOrColumn)/2;
y = reshape(x_2NRowOrColumn,2,N)';
end

