 % https://docs.google.com/spreadsheets/d/15-4sX8KxqT5d-lB1Wh7Ca_zFVR-g_80X7Oolyxgnp1A/edit#gid=0
 
clear all;

input_data = struct;

% Naty Mice
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',342);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',343);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',344);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',413);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',420);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',505);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',508);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',615);
input_data = add2struct(input_data,'fcn',@getLabelsNaty_singleMouse,'subject_identifier',619);


% Monikas mice
input_data = add2struct(input_data,'fcn',@getLabelsMoncicak_singleMouse_gsheet,'subject_identifier',430);
input_data = add2struct(input_data,'fcn',@getLabelsMoncicak_singleMouse_gsheet,'subject_identifier',534);
input_data = add2struct(input_data,'fcn',@getLabelsMoncicak_singleMouse_gsheet,'subject_identifier',397);
input_data = add2struct(input_data,'fcn',@getLabelsMoncicak_singleMouse_gsheet,'subject_identifier',490);

% Bohdana - Nikola Mice
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',725);
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',796);
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',802);
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',840);
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',867);
input_data = add2struct(input_data,'fcn',@getLabelsBohdana_singleMouse,'subject_identifier',868);

% Emsiks mice
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190313_1');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190313_2');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190313_3');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190313_4');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190327');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190409_1');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190509_1');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190509_2');
input_data = add2struct(input_data,'fcn',@getLabelsEmsik_singleMouse,'subject_identifier','jc20190509_3');


% Plotting
Nres = 1000;
rangeTime = [0 140];
time_ax=linspace(rangeTime(1),rangeTime(2),Nres);
Ntraces = numel(input_data);
seizures_yes_no = zeros(Nres,Ntraces); % each column is another mouse
seizures_yes_no_fromfirst = zeros(Nres,Ntraces); % each column is another mouse

% Compute the traces
for i = 1:Ntraces
    fcn = input_data(i).fcn;
    subject_identifier = input_data(i).subject_identifier;

     [lblPosDT , lblDurS, dob, dom] =fcn(subject_identifier);
  
     close(gcf)
     if ~isempty(lblPosDT)

        % as it is
        [~,nearest_value2time_ax_inds] = min( abs( time_ax-lblPosDT)'  ); 
        seizures_yes_no( nearest_value2time_ax_inds , i ) = true; 

        % from first
        lblPosDT = lblPosDT - min(lblPosDT);
        [~,nearest_value2time_ax_inds] = min( abs( time_ax-lblPosDT)'  ); 
        seizures_yes_no_fromfirst( nearest_value2time_ax_inds , i ) = true; 
     end
end

%
close all;
color_epipink =  [ 0.7176    0.2745    1.0000 ];

seizures_cumcount = cumsum( seizures_yes_no );

% replace maximums with NaNs
maxs_cc = max(seizures_cumcount);
for i = 1:length( maxs_cc  )
    seizures_cumcount( seizures_cumcount(:,i) == maxs_cc(i)  , i) = NaN;
end

subplot(2,2,1);
plot_cumsum(time_ax, seizures_cumcount );



subplot(2,2,3);
[r,c] = size( seizures_yes_no );
scr_ind = find( reshape( seizures_yes_no,r*c,1 ) );

% Plot spikes
rasterplot(scr_ind,c,r,'Color',color_epipink);

% Graph labels
xlabel('Time (days)');
ylabel('Animals');
title(['Raster Plot']);


subplot(2,2,[2 4]);

seizures_yes_no_fromfirst = seizures_yes_no_fromfirst(1:600,:);
[r,c] = size( seizures_yes_no_fromfirst );
scrff_ind = find( reshape( seizures_yes_no_fromfirst,r*c,1 ) );

% Plot spikes
rasterplot(scrff_ind,c,r,'Color',color_epipink);

% Graph labels
xlabel('Time from first seizure (days)');
ylabel('Animals');
title(['Raster Plot']);


% Formatting figure
hf = gcf;
hf.Position = [200 0 1600 1100];

setall('FontSize',18);

disp('finished')

save('raster_plots_data','input_data','time_ax','seizures_yes_no','seizures_yes_no_fromfirst','seizures_cumcount');
exportgraphics(gcf,'rasters_all.pdf')
savefig('rasters_all.fig');


%%
function plot_cumsum(time_ax, seizures_cumcount )
% Plot it
lblWidth = 1;
lblColor = [ 0.7176    0.2745    1.0000 ];
plot( time_ax, seizures_cumcount ,  'Color', lblColor, 'LineWidth', lblWidth, 'Marker', 'none'  );
hold on;
text(50,120, ['n=' num2str( size(seizures_cumcount,2)) ' animals'] , fontsize = 16);

% Graph labels
xlabel('Time (days)');
ylabel('Seizure count (-)');
title(['Cumulative number']);

% Formatting
hax = gca;
hax.YLim = [0 150];
end




%%
function [lblPosDT , lblDurS, dob, dom] = getLabelsNaty_singleMouse(subject_number)
path_mouse_root = '\\neurodata\Lab Neurophysiology root\EEG Naty\mTOR MUT';
T = readtable([ path_mouse_root '\zachvatujici_mysi_Naty.xlsx' ]);
empty_inds = cellfun(@isempty,T.Plasmid);
T( empty_inds , : ) = [];

row = T.ET == subject_number;

dob = datetime( T.DOB{row} , 'InputFormat', 'dd.MM.yyyy');

dom = [];


dirContents = dir(path_mouse_root);
dirContents( [dirContents.isdir] ==false)=[];
row = contains({dirContents.name} , num2str(subject_number));


% Get the data
class_names_C = {'Seizure','s'}; % ClassName to plot
minValue = 5; % Labels with value < minValue will be not plotted

single_mouse_root_path = fullfile( dirContents(row).folder , dirContents(row).name );
[lblPosDT , lblDurS] = read_fucking_kudlajdas_lbl3(single_mouse_root_path,subject_number,class_names_C,minValue);

if ~isempty(lblPosDT)
% Convert to days from the day of birth (DOB)
    lblPosDT = lblPosDT - dob;
    %lblPosDT.Format = 'd';
    lblPosDT = days(lblPosDT);
    % Plot
    plotLabelTimeDur(lblPosDT , lblDurS , num2str(subject_number) );
else
    disp(['Cound not determine labels for the mouse: ' num2str(subject_number)])
end

end



function [lblPosDT , lblDurS, dob, dom] = getLabelsEmsik_singleMouse(subject_name)

all_mice_root = '\\neurodata\Lab Neurophysiology root\Chvojka_analysis_bydate\2022-11-11_premekAllSeizuresRasterPlots\JCL labels';
l = load('\\neurodata\Lab Neurophysiology root\Chvojka_analysis_bydate\2022-11-11_premekAllSeizuresRasterPlots\subjStats.20200418.mat');
tbl = l.Ts;

row = strcmp(tbl.subjName,subject_name);

dob = datetime(datestr( tbl{row, 'dateBirth'}  ));
dom = [];

single_mouse_lbl_fp = fullfile( all_mice_root , subject_name, ['seizure-' subject_name '.jcl.mat'] );
l=load(single_mouse_lbl_fp);
tbl = l.Td;
tbl = tbl(tbl.chName == 'union1234',:);
tbl= sortrows(tbl,'startDn');

lblPosDT =  datetime(datestr( tbl.startDn  ));
lblDurS = tbl.durDn*24*60*60;

% Convert to days from the day of birth (DOB)
lblPosDT = lblPosDT - dob;
lblPosDT = days(lblPosDT);

% Plot
plotLabelTimeDur(lblPosDT , lblDurS , subject_name );
end



function [lblPosDT , lblDurS, dob, dom] = getLabelsBohdana_singleMouse(subject_number)

all_mice_root = '\\neurodata3\Lab Glia\Labels';

% Read info table
tbl = readcellstr(fullfile(all_mice_root, 'Labely_info.xlsx' )) ;

colET = contains(tbl(2, :), 'ET');
row = matches(tbl(:, colET), num2str(subject_number));

colDob = contains(tbl(2, :), 'DOB');
dob = datetime(tbl(row, colDob), 'InputFormat', 'dd.MM.yyyy');

colDom = (contains(tbl(2, :), 'DOM') );
dom = datetime(tbl(row, colDom), 'InputFormat', 'dd.MM.yyyy');


% Get the data
class_names_C = {'Seizure','s'}; % ClassName to plot
minValue = 5; % Labels with value < minValue will be not plotted

single_mouse_root_path = fullfile( all_mice_root , num2str(subject_number));
[lblPosDT , lblDurS] = read_fucking_kudlajdas_lbl3(single_mouse_root_path,subject_number,class_names_C,minValue);

if ~isempty(lblPosDT)
% Convert to days from the day of birth (DOB)
    lblPosDT = lblPosDT - dob;
    %lblPosDT.Format = 'd';
    lblPosDT = days(lblPosDT);
    % Plot
    plotLabelTimeDur(lblPosDT , lblDurS , num2str(subject_number) );
else
    disp(['Cound not determine labels for the mouse: ' num2str(subject_number)])
end

end



function [lblPosDT , lblDurS, dob, dom] = getLabelsMoncicak_singleMouse_gsheet(subject_number)
% This prints raster plot from the birth
% This function is (Jan Chvojka's clever) modification of Kudlajdas Moncicak help plotting function in OSEL
% dob = date of birth
% dom = date of monitoring

% Get data from google spreadsheet
googleSpreadsheetID = '15-4sX8KxqT5d-lB1Wh7Ca_zFVR-g_80X7Oolyxgnp1A';

tbl = GetGoogleSpreadsheet(googleSpreadsheetID);
row = matches(tbl(:, 1), num2str(subject_number));

colEEG = contains(tbl(2, :), 'EEG');
single_mouse_root_path = tbl{row, colEEG};

colDob = contains(tbl(2, :), 'DOB');
dob = datetime(tbl(row, colDob), 'InputFormat', 'dd.MM.yyyy');

colDom = (contains(tbl(2, :), 'Monitoring od') | contains(tbl(2, :), 'MonitoringOd') );
dom= datetime(tbl(row, colDom), 'InputFormat', 'dd.MM.yyyy');


% Get the data
class_names_C = {'Seizure','s'}; % ClassName to plot
minValue = 5; % Labels with value < minValue will be not plotted

[lblPosDT , lblDurS] = read_fucking_kudlajdas_lbl3(single_mouse_root_path,subject_number,class_names_C,minValue);

% Convert to days from the day of birth (DOB)
lblPosDT = lblPosDT - dob;
lblPosDT = days(lblPosDT);
% lblPosDT.Format = 'd';

% Plot
plotLabelTimeDur(lblPosDT , lblDurS , num2str(subject_number) );

%% Functions
function result = GetGoogleSpreadsheet(DOCID)
% result = GetGoogleSpreadsheet(DOCID)
% Download a google spreadsheet as csv and import into a Matlab cell array.
%
% [DOCID] see the value after 'key=' in your spreadsheet's url
%           e.g. '0AmQ013fj5234gSXFAWLK1REgwRW02hsd3c'
%
% [result] cell array of the the values in the spreadsheet
%
% IMPORTANT: The spreadsheet must be shared with the "anyone with the link" option
%
% This has no error handling and has not been extensively tested.
% Please report issues on Matlab FX.
%
% DM, Jan 2013
%
loginURL = 'https://www.google.com'; 
csvURL = ['https://docs.google.com/spreadsheet/ccc?key=' DOCID '&output=csv&pref=2'];
%Step 1: go to google.com to collect some cookies
cookieManager = java.net.CookieManager([], java.net.CookiePolicy.ACCEPT_ALL);
java.net.CookieHandler.setDefault(cookieManager);
handler = sun.net.www.protocol.https.Handler;
connection = java.net.URL([],loginURL,handler).openConnection();
connection.getInputStream();
%Step 2: go to the spreadsheet export url and download the csv
connection2 = java.net.URL([],csvURL,handler).openConnection();
result = connection2.getInputStream();
result = char(readstream(result));
%Step 3: convert the csv to a cell array
result = parseCsv(result);
end
function data = parseCsv(data)
% splits data into individual lines
data = textscan(data,'%s','whitespace','\n');
data = data{1};
for ii=1:length(data)
   %for each line, split the string into its comma-delimited units
   %the '%q' format deals with the "quoting" convention appropriately.
   tmp = textscan(data{ii},'%q','delimiter',',');
   data(ii,1:length(tmp{1})) = tmp{1};
end
end

function out = readstream(inStream)
%READSTREAM Read all bytes from stream to uint8
%From: http://stackoverflow.com/a/1323535
import com.mathworks.mlwidgets.io.InterruptibleStreamCopier;
byteStream = java.io.ByteArrayOutputStream();
isc = InterruptibleStreamCopier.getInterruptibleStreamCopier();
isc.copyStream(inStream, byteStream);
inStream.close();
byteStream.close();
out = typecast(byteStream.toByteArray', 'uint8'); 
end


end


function [lblPosDT , lblDurS] = read_fucking_kudlajdas_lbl3(single_mouse_root_path,subject_number,class_names_C,minValue)
% class_names_C ... cell of label names
% minValue ... filter by label value
%filepn_single_mouse_lbl3_C = getFilepn('Browse lbl3 files', 'on'); % Get files path and names
path_lbl3 = fullfile(single_mouse_root_path, '**\*lbl3.mat');
dirContents_lbl3=dir(path_lbl3 ); 
filepn_single_mouse_lbl3_C = fullfile({dirContents_lbl3.folder},{dirContents_lbl3.name});


lblPosDT = [];
lblDurS = [];
lblVal = [];
for k = 1 : length(filepn_single_mouse_lbl3_C)
    l = load(filepn_single_mouse_lbl3_C{k});

    fucking_ear_tags = regexp(l.sigInfo.Subject,'\d+','match','once');
     if ~all(fucking_ear_tags{1} == fucking_ear_tags) % Check the subject 
    
        %fucking_ear_tags = regexp(l.sigInfo.Subject,'\d+','match','once');
        channels = find(fucking_ear_tags == num2str(subject_number) );
    
        % Remove channels not belonging to the subject
        l.sigInfo = l.sigInfo(channels, :);
        l.lblSet = l.lblSet(ismember(l.lblSet.Channel, channels), :);
    end

%     % Find start and beginning of the labeled file
%     signalGood = [signalGood; max(l.sigInfo.SigStart), min(l.sigInfo.SigEnd)];

    lbl = l.lblSet(ismember(l.lblSet.ClassName, class_names_C ), :); % Seizure positions in datetime
    lblPosDT = [lblPosDT; lbl.Start]; % Position in datetime format
    lblDurS = [lblDurS; datenum(lbl.End - lbl.Start)*24*3600]; % Duration in days
    lblVal = [lblVal; lbl.Value]; %#ok<*AGROW>
end

% Remove labels with too low value (probably unsure labels)
lblPosDT = lblPosDT(lblVal >= minValue);
lblDurS = lblDurS(lblVal >= minValue);
lblVal = lblVal(lblVal >= minValue); %#ok<NASGU>

disp(['Maximum lbl value was: ' num2str(max(lblVal))]);

end

% function [lblPosDT , lblDurS] = read_fucking_kudlajdas_lbl3(single_mouse_root_path,subject_number,class_names_C,minValue)
% % class_names_C ... cell of label names
% % minValue ... filter by label value
% %filepn_single_mouse_lbl3_C = getFilepn('Browse lbl3 files', 'on'); % Get files path and names
% path_lbl3 = fullfile(single_mouse_root_path, '**\*lbl3.mat');
% dirContents_lbl3=dir(path_lbl3 ); 
% filepn_single_mouse_lbl3_C = fullfile({dirContents_lbl3.folder},{dirContents_lbl3.name});
% 
% l = load(filepn_single_mouse_lbl3_C{1});
% subject_in_first_lbl = l.sigInfo.Subject(1);
% if ~all(subject_in_first_lbl == l.sigInfo.Subject) % Check if Subject is the same in all channels
%     disp('Multiple subjects in the first file') % Co to kurva znamená? Jak jednoznačně určíš, jaký label v lblSet patří který myši?
% end
% 
% lblPosDT = [];
% lblDurS = [];
% lblVal = [];
% for k = 1 : length(filepn_single_mouse_lbl3_C)
%     l = load(filepn_single_mouse_lbl3_C{k});
%     if ~all(subject_in_first_lbl == l.sigInfo.Subject) % Check the subject 
%         %error(['Multiple subjects in the data set. Last loaded file:', 10, filepn{k}])
%         disp('error Kudlajzi jsi dement') 
%         %continue
%     end
%     %signalGood = [signalGood; max(l.sigInfo.SigStart), min(l.sigInfo.SigEnd)];
%     lbl = l.lblSet(ismember(l.lblSet.ClassName, class_names_C ), :); % Seizure positions in datetime
%     lblPosDT = [lblPosDT; lbl.Start]; % Position in datetime format
%     lblDurS = [lblDurS; datenum(lbl.End - lbl.Start)*24*3600]; % Duration in days
%     lblVal = [lblVal; lbl.Value]; %#ok<*AGROW>
% end
% 
% % Remove labels with too low value (probably unsure labels)
% lblPosDT = lblPosDT(lblVal >= minValue);
% lblDurS = lblDurS(lblVal >= minValue);
% lblVal = lblVal(lblVal >= minValue); %#ok<NASGU>
% 
% disp(['Maximum lbl value was: ' num2str(max(lblVal))]);
% 
% end


function plotLabelTimeDur(lblPosDT , lblDurS , plot_title)
%% Plot
% Recording 2p
%scatter(recording2p, zeros(size(recording2p)), '^k', 'MarkerFaceColor', 'k')

% Plotting settings

lblWidth = 1;
lblColor = [0.8 0.1 0];

figurePosition = [200 500 1500 400];

hold on

% Labels
stem(lblPosDT, lblDurS, 'Color', lblColor, 'LineWidth', lblWidth, 'Marker', 'none')

% Graph labels
xlabel('Age (days)')
ylabel('Duration (s)')
title(['Subject "', char(plot_title), '"'])
% title(['Subject "', char(subject), '", label class "', char(className), '"'])
% Formatting
hf = gcf;
hf.Position = figurePosition;
hax = gca;
hax.XLim(1) = hax.XLim(1)*0;
hax.XLim(2) = hax.XLim(2)+0.1*(hax.XLim(2)-hax.XLim(1)); %   duration('130:00:00:00', 'InputFormat', 'dd:hh:mm:ss');

end


function y = readcellstr(varargin)
%READTABLERAW Summary of this function goes here
%   Detailed explanation goes here
% opts = detectImportOptions(fpname);
% opts.DataRange = 'A1';
y = readcell(varargin{:},'DataRange','A1');

% turn missings into {''}
missing_value = '';
mask = cellfun(@(x) any(isa(x,'missing')), y); 
y(mask) = {missing_value};

% convert numbers o chars
y = cellfun(@num2str, y, 'UniformOutput', false);
end

function y = add2struct(x,Name, Value)
% adds some data into a growing structure
arguments
    x
end
arguments (Repeating)
    Name;
    Value;
end
    if isempty(x)
        n = 1;
    else
        if numel(fieldnames(x)) == 0
            n = 1;
        else
            n = numel(x) + 1;
        end
    end

    Npairs = (nargin-1)/2;
    for i=1:Npairs
        x(n).(Name{i}) =Value{i};
    end
    y = x;
end


function setall(varargin)
%SETALL Changes property of everything

for i = nargin/2
    hf = findobj(gcf, '-property', 'FontSize'); set(hf,{varargin{i*2-1}}, num2cell( varargin{i*2} ));
end

end


