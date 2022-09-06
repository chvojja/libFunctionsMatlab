function ycolors = favouritecolors(colors)
%FAVOURITECOLORS 

colors = cellstr(colors);

Nc = numel(colors);
ycolors = zeros(Nc,3);
for c = 1:Nc
    ycolors(c,:) = getone(colors{c});
end


% The colors:
function y = getone(color)

        switch color
            case 'epipink'
                y =[0.7176    0.2745    1.0000]; 
            case 'halflife'
                y = [0.9843    0.4941    0.0784];
        end
    
end


% oneliner
%ycolors = cell2mat(cellfun(@(x)getfield(fcolors,x) , colors , 'UniformOutput' , false));


end




