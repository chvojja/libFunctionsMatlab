function savefromgdrive(file_link)
%SAVEGDRIVE Summary of this function goes here
%   Detailed explanation goes here

% 'https://drive.google.com/file/d/1rNS0qWoRKcz8YzdODg2cb7fhkLl0WZu4/view?usp=share_link' 


% get file ID from the link
file_id = regexp( file_link , '(?<=/file/d/)\w+(?=/)' , 'match', 'once'); % maybe there should be \S+

% get file name from the web response
data = webread( file_link  , weboptions('ContentType', 'raw') )';
file_name =  regexp( data , ['(?<=''id'': ''' file_id ''', ''title'': '')\w+\.\w+(?='')' ], 'match', 'once');

% get the actual bytes of the file
data = webread( [ 'https://drive.google.com/uc?export=download&id=' file_id ] , weboptions('ContentType', 'raw') );
fid = fopen(file_name, 'wb');
fwrite(fid, data);
fclose(fid);

end



