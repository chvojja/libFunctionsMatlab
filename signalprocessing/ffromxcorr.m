function f = ffromxcorr(x,fs,Nover)
arguments 
    x;
    fs;
    Nover=[];
end

if nargin ==2
   [fp,fi,~,p]=findpeaks(xcorr(x,x),fs,'SortStr','descend'); %,'MinPeakWidth',widthSec);   
   if numel(fi)>=2
        f = 1/min(abs(fi(2:end)-fi(1)));
   else 
        f = NaN;
   end
else

   x = interpft(s,Nover*numel(x));
   [fp,fi,~,p]=findpeaks(xcorr(x,x),fs,'SortStr','descend'); %,'MinPeakWidth',widthSec);   
   if numel(fi)>=2
        f = 1/min(abs(fi(2:end)-fi(1)));
   else 
        f = NaN;
   end
end
