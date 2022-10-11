function y = loadbin(filepath, dim, precision)
%LOADBIN Loads bianary (faster)
fid = fopen(char(filepath));
y = fread(fid,dim,precision);
fclose(fid);
end

