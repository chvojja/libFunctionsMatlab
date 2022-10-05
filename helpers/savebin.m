function  savebin(filename,x)
%SAVE2DAT Faster save suitable for matrices.
% x is variable, not string
% filename is string.
    fid = fopen(filename, 'w');
    fwrite(fid,x,class(x));
    fclose(fid);
end

