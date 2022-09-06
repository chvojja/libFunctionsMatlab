function sf = downify(s)
%DOWNIFY Summary of this function goes here
%   Detailed explanation goes here
  sf = medfilt1(s,180);
  sf = filtfilt(ones(1,10)/10,1,sf);

sa = (s-sf);
 s2=s;
 s2(s>sf)=s(s>sf)-sa(s>sf);

 sf=s2;

end

