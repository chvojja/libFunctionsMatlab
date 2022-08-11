function gitPwd2Repo(nv)
% upload all files in pwd ( path working directory)
% remote repository has to be initialized (in github in browser)
% and cloned using git clone https://github.com/libgit2/libgit2
% 
arguments
    nv.Repository = 'yourRepositoryName'
end

system(['git add origin git@github.com:chvojja/' nv.Repository '.git']); % ampersand separates the commands
%     !git add .
%     !git commit -m "uploaded from Matlab using git_upload()"
%     !git push
end

