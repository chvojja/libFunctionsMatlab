function [Tlabels, fileInfo] = VKJ_lblFile2table(nv)
%VKJ_LBL2TABLE Extracts all information in lbl file to table. 

arguments 
    nv.FilePath;
    %nv.eegFilePath = []; % optional
end

% todo fileinfo 
fileInfo = [];


chNames = lblFileContent.label.(labelName).chanNames; 

chNames=chNames;
Nch=numel(chNames);
Nch=Nch;


label=load(nv.FilePath);


Tlabels = tableNewEmpty('Subject','cat',...
                    'Instant','double',...       
                   'FileName','cat',...
                   'FilePath','cat',...
                   'ChName','cat',...
                   'LabelName','cat',...
                   'StartDn','double',...
                   'EndDn','double',...
                   'DurationSec','double',...
                   'DurationDn','double',...
                   'Value','double',...
                   'Color','cat',...
                   Nrows = 1); 
% 
% Tfiles = tableNewEmpty( 'Subject','cat',...
%                    'FileName','cat',...
%                    'FilePath','cat',...
%                    'DurationFileDn','double',...
%                    Nrows = 1); 
%                    'ChNames','cell',... 
%                    'NChannels','double',... 


labelNames = fieldnames(label);
Ndet=numel(labelNames); % choose particular detection names
for kDet=1:Ndet
    labelName=labelNames{kDet};

    if isfield(label,labelName)
        chanNames = label.(labelName).chanNames;
        kchs = 1:numel(chanNames);
        for kch = kchs
            if isfield(label.(labelName),(num2kch(kch)))
                chStruct = label.(labelName).(num2kch(kch));
                if ~isempty(chStruct)
                    for i = 1:numel(chStruct.posN)  
                        Trow = table2missingRow(o.Tlabels);

Trow.Subject = label.(labelName).subject;
                   Trow.Instant','double',...       
                   Trow.FileName','cat',...
                  Trow.FilePath','cat',...
                   Trow.ChName','cat',...
                   Trow.LabelName = labelName

                        Trow.StartDn = chStruct.posN(i);
                        Trow.EndDn = chStruct.posN(i) + chStruct.durN(i);
                        Trow.DurationDn = chStruct.durN(i);
                        Trow.DurationSec = dn2sec(    chStruct.durN(i)   );
                        Trow.Value = chStruct.value(i);
                        Trow.Color= label.(labelName).color;

                        [Tlabel , inewrow] = tableAppend(Source=Trow, Target = Tlabel);
        
                    end
                end  
            end
        end
end




end

