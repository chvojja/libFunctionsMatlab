function ycolors = favouritecolors(varargin)
%FAVOURITECOLORS 
ycolors = [];
rgb_data.epipink = [0.7176    0.2745    1.0000]; 
rgb_data.halflife = [0.9843    0.4941    0.0784];
rgb_data.orange = [1 0.62 0];
rgb_data.yellow = [1 0.87 0];
rgb_data.grep = [1 0.53 0];
rgb_data.lime = [ 0.73 1 0];
rgb_data.blue = [0.14 0.83 1];
rgb_data.red = [1 0.16 0.16];
rgb_data.green = [ 0.39 0.86 0.35];
rgb_data.tyrkys = [ 0.36 0.94 0.94];
rgb_data.bege = [ 0.97 0.84 0.59];
rgb_data.premeksskin = [1 0.66 0.66];

if nargin ==0
    disp('Pick a color')
     fieldnames(rgb_data)
else
%     varargin = cellstr(varargin);
%     
    Nc = numel(varargin);
    ycolors = zeros(Nc,3);
    for c = 1:Nc
        ycolors(c,:) = rgb_data.(varargin{c});
    end
end


% oneliner
%ycolors = cell2mat(cellfun(@(x)getfield(fcolors,x) , colors , 'UniformOutput' , false));


end




