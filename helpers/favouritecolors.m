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
            case 'orange'
                y = [1 0.62 0];
            case 'yellow'
                y = [1 0.87 0];
            case 'grep'
                y = [1 0.53 0];
            case 'lime'
                y = [ 0.73 1 0];
            case 'blue'
                y = [0.14 0.83 1];
            case 'red'
                y = [1 0.16 0.16];
            case 'green'
                y = [ 0.39 0.86 0.35];
            case 'tyrkys'
                y = [ 0.36 0.94 0.94];
            case 'bege'
                y = [ 0.97 0.84 0.59];
            case 'k'
                y = [ 0 0 0 ];
            case 'w'
                y = [ 1 1 1 ]; 
            case 'premeksskin'
                y = [1 0.66 0.66];
        end
    
end


% oneliner
%ycolors = cell2mat(cellfun(@(x)getfield(fcolors,x) , colors , 'UniformOutput' , false));


end




