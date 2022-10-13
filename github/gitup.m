function gitup(nv)
% upload all files in pwd ( path working directory)
% remote repository has to be initialized (in github in browser)
% and cloned using git clone https://github.com/libgit2/libgit2
% 

arguments
    nv.Comment = 'Uploaded from Matlab using gitup()'
    nv.URL = []; % This can be either SSH or HTTPS url you got from browser at github.com 
                 % Use this if you are starting a new git repo:
                 % 1. Create a new repo at github.com
                 % 2. Launch gitup(URL = blabla.git) from Matlab at the new local folder you want to be the repo
                 % 3. This folder is now linked with your remote repo. If anything fails, check you have permissions in place
                 % or your folder is in corrrect path if you use Includeif and custom path for different git accounts work/personal
end

% addressSSH = 'git@github.com:';
% addressURL = 'https://github.com/';

if ~isempty(nv.URL) 
    disp('Using provided URL to clone the repository to a new folder.');
    system(['git clone ' nv.URL ]);
    return
end



% Try to find git accounts like:    user.name=chvojja
[stat,cmdout] = system('git config --list'); % this is global git settings
%gitAccount = regexp(cmdout,'(?<=user.name=)\D+(?=\nuser)','match'); % after user.name= is expected another user line
% gitAccount = regexp(cmdout,'(?<=user.name=)[a-z A-Z 0-9 ~!@#$%^&*()_+}{|":?><]+(?=\nuser)','match');
gitAccount = regexp(cmdout,'(?<=user.name=)\w+(?=\nuser)','match');
if ~isempty(gitAccount)
    Na = numel(gitAccount);
    disp([num2str(Na) ' git account(s) found by: git config --list ']);
    for i = 1:Na
        disp( gitAccount{i} );
    end
else
    disp('Could not find github account on this computer!!!');
    return;
end



gitAddress = regexp(cmdout,'(?<=remote.origin.url=).+(\.git)','match'); gitAddress = gitAddress{1};

if isempty(gitAddress)
%     if isempty(nv.URL)
%         disp('Run this function again with URL parameter (HTTPS/SSH) you get from your new repo at github.com');
%         if size( ls('C:\Users\Emsušenka\gitsojkaware\test2'),1)<=2
%             disp('Dont forget to add something to commit! The directory is soooooo empty!');
%         end
%         return
%     else % create a new repo
%         gitAddress = nv.URL;
%         disp('The working directory is not recognised as a local git repo, so I create it with the provided URL');
%         % system('git pull origin main --allow-unrelated-histories')
%         system(['git init & git add . & git commit -m "first commit" & git branch -M main & git remote add origin ' gitAddress ' & git pull origin main & git push -u origin main']);
% 
%     end
else
    disp(['Remote repo URL: ' gitAddress]);
    filesInDir = dirfile(pwd);
    if isempty(filesInDir)
        disp('No files to commit. Put here some files and run the function again.')
    else
        system(['git add . & git commit -m "' nv.Comment '" & git push -u origin main']); % ampersand separates the commands
        return;
    end
end





% if isfile('.git/config')
%     %configFile=fileread('.git/config');
%     %gitAddress = regexp(configFile,[addressURL '\D+.git'],'match'); %chvojja/
%     gitAddress = regexp(cmdout,'(?<=url=)\D+(?=\.git)','match');
% 
%     if ~isempty(gitAddress) 
% 
%          gitAddress = [ gitAddress{1} '.git']; % for fun
% 
%          system(['git add . & git commit -m "' nv.Comment '" & git push -u origin main']); % ampersand separates the commands
% 
%     else % if the local directory is not linked with the remote git repo yet
%         % we dont have the local repo added to remote git repo, so we need to do:
%         if ~strcmp(nv.Repo,'yourRepositoryName') % RemoteRepo was provided  % git remote set-url origin https://sojkaware@github.com/sojkaware/eco.git
%             if ~isempty(nv.RepoURL)
%                 system(['git remote add origin ' nv.RepoURL ' & git remote -v']); % ampersand separates the commands
%             else
%                 system(['git remote add origin https://github.com/' gitAccount '/' nv.Repo '.git  & git remote -v']); % ampersand separates the commands
%             end
%         else
%             disp('Run this function again, but add the RemoteRepo parameter!'); % here we dont know the remote repo name
%         end
%     end
% else
    
    








end





% system('cmd /C git commit -m "uploaded from Matlab using git_upload()" ');

%     !git add .
%     !git commit -m "uploaded from Matlab using git_upload()"
%     !git push





%%%%%%%%%%%%%%%%%%%
% 
% arguments
%     nv.Comment = 'uploaded from Matlab using gitUpload()'
%     nv.Repo = 'yourRepositoryName';
%     nv.RepoURL = []; % you get this by copy pastinf from web
% end
% addressSSH = 'git@github.com:';
% addressURL = 'https://github.com/';
% 
% % user.name=chvojja
% [stat,cmdout] = system('git config --list');
% gitAccount = regexp(cmdout,'(?<=user.name=)\D+(?=\n)','match');
% if ~isempty(gitAccount)
%     gitAccount = gitAccount{1};
% else
%     disp('Could not find github account!!!')
% end
% 
% 
% if isfile('.git/config')
%     configFile=fileread('.git/config');
%     gitAddress = regexp(configFile,[addressURL '\D+.git'],'match'); %chvojja/
%     if ~isempty(gitAddress) 
%           % gitAddress = gitAddress{1}; % for fun
% 
%          system(['git add . & git commit -m "' nv.Comment '" & git push -u origin main']); % ampersand separates the commands
% 
%     else % if the local directory is not linked with the remote git repo yet
%         % we dont have the local repo added to remote git repo, so we need to do:
%         if ~strcmp(nv.Repo,'yourRepositoryName') % RemoteRepo was provided
%             if ~isempty(nv.RepoURL)
%                 system(['git remote add origin ' nv.RepoURL ' & git remote -v']); % ampersand separates the commands
%             else
%                 system(['git remote add origin https://github.com/' gitAccount '/' nv.Repo '.git  & git remote -v']); % ampersand separates the commands
%             end
%         else
%             disp('Run this function again, but add the RemoteRepo parameter!'); % here we dont know the remote repo name
%         end
%     end
% else
%     disp('The working directory is not recognised as a local git repo...')
% end
% 
% 
% 
% 
% 
% % system('cmd /C git commit -m "uploaded from Matlab using git_upload()" ');
% 
% %     !git add .
% %     !git commit -m "uploaded from Matlab using git_upload()"
% %     !git push


