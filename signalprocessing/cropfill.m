function [s,Nsignal] = cropfill(nv)
%CROPFILLMEAN Summary of this function goes here
arguments
    nv.Signal;
    nv.CropPercent=[];
    nv.CropSamples=[];
    nv.WhatToFill = []; % fun(signal) or a numeric value
    nv.KeepPercent = [];
    nv.KeepSamples = [];
end

Nsignal = length(nv.Signal);

if ~isempty(nv.CropPercent)
    offsetDet = round((nv.CropPercent/100)*Nsignal/2);
    offsetDet2=offsetDet;
end
if ~isempty(nv.KeepPercent)
    offsetDet = round(((100-nv.KeepPercent)/100)*Nsignal/2);
    offsetDet2=offsetDet;
end   

if ~isempty(nv.CropSamples)
    offsetDet = nv.CropSamples;
    offsetDet2=offsetDet;
end

if ~isempty(nv.KeepSamples)
    offsetDet = ceil(Nsignal-nv.KeepSamples)/2;
%     if odd(Nsignal)
%         offsetDet2 = offsetDet;
%     else
%         offsetDet2 = offsetDet;
%     end
end
       
    

  

 logiL =[1:Nsignal <=offsetDet |  1:Nsignal > Nsignal-offsetDet ]' ;

     if isfunctionhandle(nv.WhatToFill)    
        nv.Signal(logiL)=nv.WhatToFill(nv.Signal);
     elseif isnumeric(nv.WhatToFill)
         if isempty(nv.WhatToFill)
             nv.Signal(logiL)= [];
         else
             nv.Signal(logiL)=nv.WhatToFill;
         end
     end

     s = nv.Signal;
end

