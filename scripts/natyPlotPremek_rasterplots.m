
%% Get info about mice

path_mouse_root = '\\neurodata\Lab Neurophysiology root\EEG Naty\mTOR MUT';
T = readtable([ path_mouse_root '\zachvatujici_mysi_Naty.xlsx' ]);
empty_inds = cellfun(@isempty,T.Plasmid);
T( empty_inds , : ) = [];


%% Link folder to mouse ear tag

path_lbl3 = '\\neurodata\Lab Neurophysiology root\EEG Naty\mTOR MUT\**\*lbl3.mat';
dirContents_lbl3=dir(path_lbl3); 

for i = 1:size(dirContents_lbl3,1)

    [ ~ , path_rest ] = splitpath(  dirContents_lbl3(i).folder   , ByFolder= 'mTOR MUT' );

    subjectNumber = regexp( nextFolder(path_rest,0) , '\d\d\d','match','once') ;
    dirContents_lbl3(i).etag = subjectNumber;
    dirContents_lbl3(i).fpath =  [ dirContents_lbl3(i).folder '\' dirContents_lbl3(i).name ];
end


%% Plotting
for i = 6:size(T,1)
    etag = T.ET(i);
    startTime = datetime(   T.DOB(i)   , 'InputFormat', 'dd.MM.yyyy');


    files_singe_etag_logi = strcmp({dirContents_lbl3.etag}, num2str(etag) );
    dirContents_one_mouse =  dirContents_lbl3(files_singe_etag_logi);
    

    plot_seizures1( {dirContents_one_mouse.fpath} ,etag,startTime);
    fpath_fig = fullfile(path_mouse_root , [num2str(etag) '.fig' ]);
    %mkdir(fpath_fig);
    savefig(gcf,fpath_fig);
    close(gcf);
end

%

function  plot_seizures1(filepn,etag,startTime)

className = "Seizure"; % ClassName to plot
minValue = 5; % Labels with value < minValue will be not plotted

lblWidth = 1;
lblColor = [0.8 0.1 0];

figurePosition = [200 500 1500 400];

%% Get the data
%filepn = getFilepn('Browse lbl3 files', 'on'); % Get files path and names

l = load(filepn{1});
subject = l.sigInfo.Subject(1);
if ~all(subject == l.sigInfo.Subject) % Check if Subject is the same in all channels
    error('Multiple subjects in the first file')
end
signalGood = [];
lblPosDT = [];
lblDurS = [];
lblVal = [];
for k = 1 : length(filepn)
    l = load(filepn{k});
    if ~all(subject == l.sigInfo.Subject) % Check the subject
        %error(['Multiple subjects in the data set. Last loaded file:', 10, filepn{k}])
        disp('error subject')
        continue
    end
    signalGood = [signalGood; max(l.sigInfo.SigStart), min(l.sigInfo.SigEnd)];
    lbl = l.lblSet(l.lblSet.ClassName == className, :); % Seizure positions in datetime
    lblPosDT = [lblPosDT; lbl.Start]; % Position in datetime format
    lblDurS = [lblDurS; datenum(lbl.End - lbl.Start)*24*3600]; % Duration in days
    lblVal = [lblVal; lbl.Value]; %#ok<*AGROW>
end

% Remove labels with too low value (probably unsure labels)
lblPosDT = lblPosDT(lblVal >= minValue);
lblDurS = lblDurS(lblVal >= minValue);
lblVal = lblVal(lblVal >= minValue); %#ok<NASGU>


%startTime = datetime(   , 'InputFormat', 'dd.MM.yyyy');

% Convert to days from the day of birth (DOB)
lblPosDT = lblPosDT - startTime;
lblPosDT.Format = 'd';


% % Recording 2p
% scatter(recording2p, zeros(size(recording2p)), '^k', 'MarkerFaceColor', 'k')
hold on

% Labels
stem(lblPosDT, lblDurS, 'Color', lblColor, 'LineWidth', lblWidth, 'Marker', 'none')

% Graph labels
xlabel('Age (days)')
ylabel('Duration (s)')
%title(['Subject "', char(subject), '"']);
title(['Subject "', num2str(etag) , '"']);
% title(['Subject "', char(subject), '", label class "', char(className), '"'])
% Formatting
hf = gcf;
hf.Position = figurePosition;
hax = gca;
hax.XLim(1) = hax.XLim(1)*0;
hax.XLim(2) = duration('160:00:00:00', 'InputFormat', 'dd:hh:mm:ss');

end

% Functions
function filepn = getFilepn(prompt, multisel)
    if exist('loadpath.mat', 'file')
        load('loadpath.mat', 'loadpath'); % Second argument: which variable from the file should be loaded
    else
        loadpath = '';
    end
    [fn, fp] = uigetfile([loadpath, '\*.*'], prompt, 'MultiSelect', multisel); % File names, file path
    if isa(fn, 'double')
        filepn = [];
        return
    end
    % If the user selected only one file, it is returned as a char array. Let's put it in a cell for consistency.
    if ~iscell(fn)
        filen{1} = fn;
    else
        filen = fn;
    end
    filep = fp;
    filepn = fullfile(filep, filen);
    loadpath = filep;
    save('loadpath.mat', 'loadpath')
end





