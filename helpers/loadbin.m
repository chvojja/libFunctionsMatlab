function y = loadbin(filepath, dim, precision)
%LOADBIN Loads bianary (faster)
fid = fopen(filepath);
y = fread(fid,dim,precision);
fclose(fid);
end

