function data = loaddata(filepath)
%LOADDATA Loads a 'data' variable from a single file

load(filepath);


if ~exist('data','var')
    if exist('x','var')
        data = x; 
    else
        disp('Loading data failed.');
    end
end

end

