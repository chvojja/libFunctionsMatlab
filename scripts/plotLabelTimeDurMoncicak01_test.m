
%% Fucking plotovani labelu z OSLA
% \\neurodata\Lab Neurophysiology root\EEG Naty\mTOR MUT
subjectNumber = 397;

className = "Seizure"; % ClassName to plot
minValue = 5; % Labels with value < minValue will be not plotted

lblWidth = 1;
lblColor = [0.8 0.1 0];

figurePosition = [200 500 1500 400];

%% Get the data
filepn = getFilepn('Browse lbl3 files', 'on'); % Get files path and names
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
        error(['Multiple subjects in the data set. Last loaded file:', 10, filepn{k}])
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
title(['Subject "', char(subject), '"'])
% title(['Subject "', char(subject), '", label class "', char(className), '"'])
% Formatting
hf = gcf;
hf.Position = figurePosition;
hax = gca;
hax.XLim(1) = hax.XLim(1)*0;
hax.XLim(2) = duration('160:00:00:00', 'InputFormat', 'dd:hh:mm:ss');



%% Functions
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





