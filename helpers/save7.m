% save7 script v1.0
% What it does:
% 1. Saves variables solely in -v7 .mat format
% 2. The name of the variable as .mat file is always the same as the name in the workspace. 
%
% What problems does it solve:
% 1. By using Matlab's native save(filename, variable..), you need to type the name of the variable twice.
% You wonder why not just write a wrapper around Matlab's native save(). 
% Well, you can and you can use inputname() to determine the original name of the variables in the Workspace before the call.
% But it works only with simpel data types...
%
% 2. By using Matlab's native save(filename, variable.. , -append ) to add some variable(s) to existing .mat,
% the file, the file starts to increase in size everytime you update some variable in it. You can not controll that. 
% So storing multiple variables in a single .mat with frequent updates of the parts of the .mat is not good. 
% The only way around that is loading the big .mat, updating the variable and saving it back again to prevent swelling of the .mat.
% Or you can use save7 to store each variable conveniently separatly!!!! 
%
%
% Examples how to use:
% To save a single variable by providing file path:       
%
%                                  save7fp = 'D:\temp_FCD_analyza_1\c.mat'; save7
%
% To save multiple variables by providing path and names of the variables:     
%
%                                  save7p = 'D:\temp_FCD_analyza_1'; save7vars = 'IEDs c back'; save7
%                                  save7p = 'D:\temp_FCD_analyza_1'; save7vars = {'IEDs' 'c' 'back'}; save7
%
%
% Jan Chvojka (2022)


if exist('verbose','var') 
    save7verbose=verbose;
else
    save7verbose=true;
end
save7success = false;


% save7  - saving by file path
% input parameters:
% save7fp ... file path char
if exist('save7fp','var') && ~isempty(save7fp)
    [~,save7fn,save7fext] =fileparts(save7fp);
    if exist('save7fn','var') 
        save(save7fp, save7fn , '-v7');
        save7success = true;
    else
        disp2(save7verbose,'save7 did not find the desired variable.');
    end
    clear save7fn save7fext save7fp;

end


% save7  - saving by path and variable names
% input parameters:
% save7p ... path char
% save7vars ... variables to save,  chars with  soem reasonable delimiter or cell array
if exist('save7p','var') && ~isempty(save7p)  &&  exist('save7vars','var') && ~isempty(save7vars) 
    if ischar(save7vars), save7vars  = charArgs2cell(save7vars); end;
    for save7iv = 1:numel(save7vars)
        save7var = save7vars{save7iv};
        if exist('save7var','var') 
            save(  fullfile( save7p , [save7var , '.mat'] )   , save7var  , '-v7');
            save7success = true;
        else
            disp2(save7verbose,'save7 did not find the desired variable.');
        end
    end
    clear save7p save7vars save7var save7iv ;
else
    disp2(save7verbose,'save7 was not provided with valid parameters.');
end


% Check success
if save7success 
    disp2(save7verbose,'save7 saved the file(s).');
else
    disp2(save7verbose,'save7 was provided with wrong parameters. Nothing was saved.');
end

% clear the mess
clear save7verbose save7success;