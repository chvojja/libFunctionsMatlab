function [data,fs,chanNames] = loadH5ondrej(fpname,zesileni)
% Jan Chvojka super function
%
% zesileni = cislo ktere odpovida hodnote knobu zesileni na modrem AMsystems zesilovaci

hi=h5info(fpname);
ds = [ hi.Groups(2).Name '/analogScans' ]; % datastoreName
data = h5read(fpname,ds);

% chanNames
Nch = size(data,2);

try
    chnm = h5read(fpname, '/header/AllChannelNames');
    chanNames = cellstr(chnm);
    if numel(chanNames)~=Nch
        disp('Channels dont match');
    end
catch
    chanNames = arrayfun(@num2str,1:Nch,'UniformOutput',false)';
end
% Sampling rate
fs = h5read(fpname, '/header/AcquisitionSampleRate');




% Ondrejovo nastaveni
rozsah=10; %% rozsah digitizeru je +/-10V
mVmistoV=1000; %%zobrazit mV
data = double(data)/(2^15)*rozsah/zesileni*mVmistoV;



