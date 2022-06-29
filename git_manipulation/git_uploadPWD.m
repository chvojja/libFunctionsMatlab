function git_uploadPWD()
% upload all files in pwd ( path working directory)
% remote repository has to be initialized already
arguments

end
    !git add .
    !git commit -m "uploaded from Matlab"
    !git push
end

