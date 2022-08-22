function gitup(nv)
% upload all files in pwd ( path working directory)
% remote repository has to be initialized (in github in browser)
% and cloned using git clone https://github.com/libgit2/libgit2
% 

arguments
    nv.Comment = 'uploaded from Matlab using gitUpload()'
    nv.Repo = 'yourRepositoryName';
    nv.RepoURL = []; % you get this by copy pastinf from web
end
addressSSH = 'git@github.com:';
addressURL = 'https://github.com/';

% user.name=chvojja
[stat,cmdout] = system('git config --list');
gitAccount = regexp(cmdout,'(?<=user.name=)\D+(?=\n)','match');
if ~isempty(gitAccount)
    gitAccount = gitAccount{1};
else
    disp('Could not find github account!!!')
end


if isfile('.git/config')
    configFile=fileread('.git/config');
    gitAddress = regexp(configFile,[addressURL '\D+.git'],'match'); %chvojja/
    if ~isempty(gitAddress) 
          % gitAddress = gitAddress{1}; % for fun

         system(['git add . & git commit -m "' nv.Comment '" & git push -u origin main']); % ampersand separates the commands

    else % if the local directory is not linked with the remote git repo yet
        % we dont have the local repo added to remote git repo, so we need to do:
        if ~strcmp(nv.Repo,'yourRepositoryName') % RemoteRepo was provided
            if ~isempty(nv.RepoURL)
                system(['git remote add origin ' nv.RepoURL ' & git remote -v']); % ampersand separates the commands
            else
                system(['git remote add origin https://github.com/' gitAccount '/' nv.Repo '.git  & git remote -v']); % ampersand separates the commands
            end
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

