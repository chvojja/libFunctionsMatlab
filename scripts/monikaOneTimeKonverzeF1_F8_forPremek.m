
% \\neurodata3\Lab Neuro Optophys\Ca imaging\Monika 2p
% \\neurodata2\Large data\Monika 2p\VIP_tdT
% \\neurodata2\Large data\Monika 2p\VIP_tdT WT mTOR

% % Monikas computer paths
% 'A:\VIP_tdT');
% 'A:\VIP_tdT WT mTOR');
% 'E:\Ca imaging\Monika 2p');

% my computer path
path_output = '\\neurodata2\Large data\Monika 2p\2022-11-02 Monika_Premek_konverze_fullfs';
h52premek('\\neurodata2\Large data\Monika 2p\VIP_tdT WT mTOR',path_output);
h52premek('\\neurodata2\Large data\Monika 2p\VIP_tdT',path_output);
h52premek('\\neurodata3\Lab Neuro Optophys\Ca imaging\Monika 2p',path_output);
function h52premek(path_root,path_output)
mkdir(path_output) 

dd = dir([path_root '\**\']);
paths_onedot = [strcmp({dd.name},'.') ]';
paths_isdir = [dd.isdir]';
paths_number_and_Fx =  ~cellfun('isempty', regexpi( { dd.folder}' , '.+\d\d\d\sF\d$','once') );
paths_sel = paths_onedot & paths_isdir & paths_number_and_Fx;
dd_Fx_folders = dd(paths_sel);

    Nh5_Fx_folders = numel(dd_Fx_folders);
    for i = 1:Nh5_Fx_folders % each iteration produce Fx file
    
        path_root = dd_Fx_folders(i).folder;
        % mouse number
        [~,last_folder] = fileparts(path_root);
        matches = regexp(last_folder,'(?<eartag>\d\d\d)\s(?<f_measurement>F\d)','names');
        fname_Fx_prefix = [ 'Mereni_' matches.f_measurement '_' ];
  
        dirContents_output_eartag=dir([path_output '\' matches.eartag '\' fname_Fx_prefix '*.mat']); 
        if ~isempty( dirContents_output_eartag )
            disp( ['skipping ' last_folder ] );
            continue
        end

        disp( ['converting ' last_folder ] );
       
        
    
        dirContents_h5=dir([path_root '\*.h5']);  % we want just one level deep folder not subfolders
    
        %connect_files_save( dirContents_h5 , matches.eartag , matches.f_measurement )
        %  now connect the files and save
        Nh5files_one_fxFolder = numel(dirContents_h5);
        sC = cell(Nh5files_one_fxFolder,1);
        for j = 1:Nh5files_one_fxFolder
            
            try
                fp_name = [ dirContents_h5(j).folder '\' dirContents_h5(j).name ];
                lf = loadH5ondrej(fp_name,1000); % zesileni 1000, fs = 20000
                sC{j}=lf';
                %dateN=df.datenum;
            catch ME
                disp(['monco, soubor: ' fp_name ' nejde nacist, asi je to rozbity.']);
                continue;
            end
    
    
    
        end
        s = [sC{:}];
        fs = 20000;
        mkdir([ path_output '\' matches.eartag ]);
        fname = [fname_Fx_prefix datestr(datenum(regexp(fp_name,'\d\d\d\d\d\d\d\d','match','once'),'yyyymmdd'),'yyyymmdd')  '.mat'];
        fpname_out = [ path_output '\' matches.eartag '\' fname ];
        save(fpname_out,'s','fs');
        disp(['saved  ' fpname_out]);
    
    end


end
