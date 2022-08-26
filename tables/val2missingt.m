function y = val2missingt(x)
%FILLMISSINGS Return default missing for particular value in x
% x is one 1x1 element of something

switch class(x)
    case 'table'
        y = [];

    case 'cell'
        y = {[]};

    case 'logical'
        y = false; %!!!!!!!!!!!!!!!!!!!!!!!!!!

    case {'int8','int16' ,'int32' ,'int64' , 'uint8','uint16' ,'uint32' ,'uint64' }  
        y = 0;  

    otherwise
        y = missing;

end

