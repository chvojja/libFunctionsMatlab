function units_C = axesunits(hax,units)
%BACKUPUNITS Summary of this function goes here
%   Detailed explanation goes here
if iscell(units)
   [hax(:).Units] = units{:}; % change units, comma separated way
else % units = 'centimeters'
    units_C = {hax(:).Units}; % backup units
    [hax(:).Units] = deal( units ); % change units , comma separated way
end
end

