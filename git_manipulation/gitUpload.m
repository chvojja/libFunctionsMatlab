function gitUpload(nv)
% upload all files in pwd ( path working directory)
% remote repository has to be initialized (in github in browser)
% and cloned using git clone https://github.com/libgit2/libgit2
% 
arguments
    nv.Comment = 'uploaded from Matlab using gitUpload()'
    nv.GitAccount = 'chvojja'
    nv.RemoteRepo = 'yourRepositoryName';
end

if isfile('.git/config')
    configFile=fileread('.git/config');
    gitAddress = regexp(configFile,'https://github.com/\D+.git','match');
    if ~isempty(gitAddress)
         gitAddress = gitAddress{1};
         gitAccount = regexp(gitAddress,'(?<=https://github.com/)\D+(?=/)','match');
         if ~isempty(gitAccount) 
             if ~strcmp(gitAccount {1},nv.GitAccount)
                 disp('Git accounts dont match!!')
             else
                nv.GitAccount  = gitAccount {1};
                
             end
             system(['git add . & git commit -m "' nv.Comment '" & git push']); % ampersand separates the commands
    
         else
             disp('Git Account name could not be found.')
         end
    else
        % we dont have the local repo added to remote git repo, so we need to do:
        if ~strcmp(nv.RemoteRepo,'yourRepositoryName') % RemoteRepo was provided
            system(['git remote add origin https://github.com/' nv.GitAccount '/' nv.RemoteRepo '.git  & git remote -v']); % ampersand separates the commands
        else
            disp('Run this function again, but add the RemoteRepo parameter!'); % here we dont know the remote repo name
        end
    end
else
    disp('The working directory is not recognised as a local git repo...')
end





% system('cmd /C git commit -m "uploaded from Matlab using git_upload()" ');

%     !git add .
%     !git commit -m "uploaded from Matlab using git_upload()"
%     !git push
end

