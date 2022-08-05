function [subject,time_dn,station,type] = VKJ_parseFileName(fname)
%VKJ_PARSEFILENAME 
% parses file name in VKJ format
isMatIdx = regexpi(fname,'.mat$');
if ~isempty(isMatIdx)
    fname = fname(1:end-4);
        subStringMatch = regexp(fname,'^\D\D.+\-\d\d\d\d\d\d\D\d\d\d\d\d\d\-','match','once'); % check if it starts with jk2018...
        yymmdd_hhmmssIdx = regexpi(subStringMatch, '\-\d\d\d\d\d\d\D\d\d\d\d\d\d\-') + 1; % Date time index
        yymmdd_hhmmss = [subStringMatch(yymmdd_hhmmssIdx:yymmdd_hhmmssIdx+5) fname(yymmdd_hhmmssIdx+7:yymmdd_hhmmssIdx+12) ]; 
        time_dn = datenum(yymmdd_hhmmss,['yymmddHHMMSS']);
        
        subject = subStringMatch(1:yymmdd_hhmmssIdx-2);

        %stationAndregexpi(fname,'\-[A-Z]+\d*(\-\d+)*\.mat$','match','once')

        stationPart =  fname(yymmdd_hhmmssIdx+14:end);

        isItLabelIdx = regexpi(stationPart,'\-lbl$');
        if isempty(isItLabelIdx) % eeg file
            station = parseRest(stationPart);
            type = 'eeg';
        else % label file
            station = parseRest(stationPart(1:end-4));
            type = 'lbl';
        end
else
    disp('fucking file is not a matlab file');
end

    function station = parseRest(stationPart)
            numberIdx = regexpi(stationPart,'\-\d+$');
            if isempty(numberIdx)
                    station = stationPart(1:end);
            else
                station = stationPart(1:numberIdx-1);
            end
    end
end

