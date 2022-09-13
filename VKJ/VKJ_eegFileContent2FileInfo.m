function fileInfo = VKJ_eegFileContent2FileInfo(eegFileContent)
%VKJ_FILECONTENT2FILEINFO Summary of this function goes here
%   Detailed explanation goes here

fileInfo.N=size(eegFileContent.s,2);
% Overall file info
fileInfo.fileStart = datestr(eegFileContent.dateN);
fileInfo.fileStartDn = eegFileContent.dateN;
    endDn = eegFileContent.dateN + sec2dn(fileInfo.N/eegFileContent.fs);
fileInfo.fileEnd = datestr( endDn );
fileInfo.fileEndDn = endDn;
fileInfo.fileDurDn =  endDn-eegFileContent.dateN;


end

