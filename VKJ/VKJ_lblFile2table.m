function [Tlabels, fileInfo] = VKJ_lblFile2table(nv)
%VKJ_LBL2TABLE Extracts all information in lbl file to table. 

arguments 
    nv.FilePath;
    %nv.eegFilePath = []; % optional
end

% todo fileinfo 
fileInfo = [];



label=load2(nv.FilePath);

%                    'FileName','cat',...
%                    'FilePath','cat',...
TmissingRow = tableNewEmpty('Subject','cat',...
                    'Instant','double',...       
                   'ChName','cat',...
                   'LabelName','cat',...
                   'StartDn','double',...
                   'EndDn','double',...
                   'DurationSec','double',...
                   'DurationDn','double',...
                   'Value','double',...
                   'Color','cat',...
                   Nrows = 1); 
%Trow = table2missingRow(Tlabels);
% 
% Tfiles = tableNewEmpty( 'Subject','cat',...
%                    'FileName','cat',...
%                    'FilePath','cat',...
%                    'DurationFileDn','double',...
%                    Nrows = 1); 
%                    'ChNames','cell',... 
%                    'NChannels','double',... 

Tlabels = TmissingRow;   Tlabels(1,:) = [];

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
                        
                        Trow = TmissingRow;

                        Trow.Subject = label.(labelName).subject;
                        Trow.Instant = double(label.(labelName).instant) ;   
                        Trow.ChName = chStruct.ChName;
                        Trow.LabelName = labelName;
                        Trow.StartDn = chStruct.posN(i);
                        Trow.EndDn = chStruct.posN(i) + chStruct.durN(i);
                        Trow.DurationDn = chStruct.durN(i);
                        Trow.DurationSec = dn2sec(    chStruct.durN(i)   );
                        Trow.Value = chStruct.value(i);
                        Trow.Color= label.(labelName).color;

                        Tlabels = [Tlabels; Trow;];

                        %[Tlabels , inewrow] = tableAppend(Source=Trow, Target = Tlabels);
        
                    end
                end  
            end
        end
end



end

%Tlabels(1,:) = [];


end

