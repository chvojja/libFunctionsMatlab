function y = isDirPath(path)
%ISDIRPATH
[basePath,~,ext]=fileparts(path);

if ~isempty(basePath) && isempty(ext)
    y = true;
else
    y = false;
end


end

