function [subject,time_dn,station] = VKJ_parseFileName(fname)
%VKJ_PARSEFILENAME 
% parses file name in VKJ format
        subStringMatch = regexp(fname,'^\D\D.+\-\d\d\d\d\d\d\D\d\d\d\d\d\d\-','match','once'); % check if it starts with jk2018...
        yymmdd_hhmmssIdx = regexpi(subStringMatch, '\-\d\d\d\d\d\d\D\d\d\d\d\d\d\-') + 1; % Date time index
        yymmdd_hhmmss = [subStringMatch(yymmdd_hhmmssIdx:yymmdd_hhmmssIdx+5) fname(yymmdd_hhmmssIdx+7:yymmdd_hhmmssIdx+12) ]; 
        time_dn = datenum(yymmdd_hhmmss,['yymmddHHMMSS']);
        
        subject = subStringMatch(1:yymmdd_hhmmssIdx-2);

        %stationAndregexpi(fname,'\-[A-Z]+\d*(\-\d+)*\.mat$','match','once')

        stationPart =  fname(yymmdd_hhmmssIdx+14:end);
        numberIdx = regexpi(stationPart,'\-\d+\.mat$');
       
        if isempty(numberIdx)
            station = stationPart(2:end-4);
        else
            station = stationPart(1:numberIdx-1);
        end



        


end

