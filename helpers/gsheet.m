function y = gsheet(gsheet_link,sheet_id)
arguments
    gsheet_link;
    sheet_id = [];
end
%gsheet_link = 'https://docs.google.com/spreadsheets/d/15-4sX8KxqT5d-lB1Wh7Ca_zFVR-g_80X7Oolyxgnp1A/export?format=csv&gid=0';

% get file ID from the link
gsheet_document_id = regexp( gsheet_link , '(?<=/spreadsheets/d/)\S+(?=/)' , 'match', 'once');
gsheet_prefix = ['https://docs.google.com/spreadsheets/d/'];

switch nargin
    case 1    
        gsheet_table = webread( [gsheet_prefix gsheet_document_id '/export?format=csv' ] );
    case 2
        gsheet_table = webread( [gsheet_prefix gsheet_document_id '/export?format=csv&gid=' num2str(sheet_id) ] );
end
y=gsheet_table;
%gsheet_link ... 'https://docs.google.com/spreadsheets/d/15-4sX8KxqT5d-lB1Wh7Ca_zFVR-g_80X7Oolyxgnp1A/export?format=csv&gid=0'

end



















% % result = GetGoogleSpreadsheet(DOCID)
% % Download a google spreadsheet as csv and import into a Matlab cell array.
% %
% % [DOCID] see the value after 'key=' in your spreadsheet's url
% %           e.g. '0AmQ013fj5234gSXFAWLK1REgwRW02hsd3c'
% %
% % [result] cell array of the the values in the spreadsheet
% %
% % IMPORTANT: The spreadsheet must be shared with the "anyone with the link" option
% %
% % This has no error handling and has not been extensively tested.
% % Please report issues on Matlab FX.
% %
% % DM, Jan 2013
% %
% loginURL = 'https://www.google.com'; 
% csvURL = ['https://docs.google.com/spreadsheet/ccc?key=' DOCID '&output=csv&pref=2'];   
% %Step 1: go to google.com to collect some cookies
% cookieManager = java.net.CookieManager([], java.net.CookiePolicy.ACCEPT_ALL);
% java.net.CookieHandler.setDefault(cookieManager);
% handler = sun.net.www.protocol.https.Handler;
% connection = java.net.URL([],loginURL,handler).openConnection();
% connection.getInputStream();
% %Step 2: go to the spreadsheet export url and download the csv
% connection2 = java.net.URL([],csvURL,handler).openConnection();
% result = connection2.getInputStream();
% result = char(readstream(result));
% %Step 3: convert the csv to a cell array
% result = parseCsv(result);
% end
% 
% function data = parseCsv(data)
% % splits data into individual lines
% data = textscan(data,'%s','whitespace','\n');
% data = data{1};
% for ii=1:length(data)
%    %for each line, split the string into its comma-delimited units
%    %the '%q' format deals with the "quoting" convention appropriately.
%    tmp = textscan(data{ii},'%q','delimiter',',');
%    data(ii,1:length(tmp{1})) = tmp{1};
% end
% end
% 
% 
% function out = readstream(inStream)
% %READSTREAM Read all bytes from stream to uint8
% %From: http://stackoverflow.com/a/1323535
% import com.mathworks.mlwidgets.io.InterruptibleStreamCopier;
% byteStream = java.io.ByteArrayOutputStream();
% isc = InterruptibleStreamCopier.getInterruptibleStreamCopier();
% isc.copyStream(inStream, byteStream);
% inStream.close();
% byteStream.close();
% out = typecast(byteStream.toByteArray', 'uint8'); 
% end

