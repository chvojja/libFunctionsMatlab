function y = val2missing(x)
%FILLMISSINGS Return default missing for particular value in x
% x is one 1x1 element of something

switch class(x)
    case 'table'
        y = [];

    case 'cell'
        y = {[]};

    case 'logical'
        y = false; %!!!!!!!!!!!!!!!!!!!!!!!!!!

    otherwise
        y = missing;

end

