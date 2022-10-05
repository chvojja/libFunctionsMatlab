function h = confidenceshade(x,yl,yh,nv)
%CONFIDENCESHADE Summary of this function goes here
%   Detailed explanation goes here
arguments
    x = [1 ; 2; 3 ;4];
    yl = [1 ; 2; 3 ;4];
    yh = [1.2; 2.5; 3.8; 4.1];
    nv.Color = 'r';
    nv.PatchArgs = {}; % optional arguments, can override the defaults
end
x = x(:); % make all column
yl = yl(:);
yh = yh(:);
defArgs = {'FaceAlpha',0.2,'EdgeColor','none'};
h = patch([x; flipud(x)], [yh; flipud(yl)], nv.Color, defArgs{:}, nv.PatchArgs{:}); 

end

