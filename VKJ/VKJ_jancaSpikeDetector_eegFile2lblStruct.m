function [label,fileInfo]=VKJ_jancaSpikeDetector_eegFile2lblStruct(nv)
arguments
    nv.FilePath;
    nv.Name = 'JancaSpikeDetectorDefault';
    nv.Color = '1 0 0';
    nv.Settings = [];
    nv.Value = 5;
end

[nv.Name,nv.Color,nv.Settings,nv.Value, Nruns] = args2cell(nv.Name,nv.Color,nv.Settings,nv.Value);

nv.FilePath = char(nv.FilePath);
eegFileContent = load(nv.FilePath);
%N=size(eegFileContent.s,2);
label = struct;

% Overall file info


fileInfo = VKJ_eegFileContent2FileInfo(eegFileContent);

[~,eegFileName,ext] = fileparts(nv.FilePath);
fileInfo.srcSigFile = [eegFileName ext];

% Nruns = numel(nv.Name);


for kr =1:Nruns
        if isempty(nv.Settings{kr})
            out = spike_detector_hilbert_v23(eegFileContent.s',eegFileContent.fs);
        else
            out = spike_detector_hilbert_v23(eegFileContent.s',eegFileContent.fs,nv.Settings{kr}); %-w 25000 -n 10000');
        end
        
        
        label.(nv.Name{kr}).name = nv.Name{kr};
        label.(nv.Name{kr}).color = nv.Color{kr};
        label.(nv.Name{kr}).instant = false;
        label.(nv.Name{kr}).chanNames = eegFileContent.chanNames;
        label.(nv.Name{kr}).subject = eegFileContent.subject;
        label.(nv.Name{kr}).fileStart =  fileInfo.fileStart;
        label.(nv.Name{kr}).fileEnd = fileInfo.fileEnd ;
        label.(nv.Name{kr}).fileDurDn = fileInfo.fileDurDn;

        label.(nv.Name{kr}).srcSigFile = fileInfo.srcSigFile;
        
        chans=unique(out.chan);
        for kch = chans' %1:numel(chans)
        %     chOne=chans(kch);
        %     idx=out.chan==chOne;
        
            idx=out.chan==kch;
            label.(nv.Name{kr}).(num2kch(kch)).posN=eegFileContent.dateN+sec2dn(out.pos(idx))';
            label.(nv.Name{kr}).(num2kch(kch)).durN=sec2dn(out.dur(idx)');
            label.(nv.Name{kr}).(num2kch(kch)).value=[nv.Value{kr}*ones(1,numel(find(idx)))];
            
            % debilni hodnoty pro kudljze
            label.(nv.Name{kr}).(num2kch(kch)).chan=kch;
            label.(nv.Name{kr}).(num2kch(kch)).chanType=1;
            % debilni hodnoty pro me
            label.(nv.Name{kr}).(num2kch(kch)).ChName=eegFileContent.chanNames{kch};
            label.(nv.Name{kr}).(num2kch(kch)).fileStart= fileInfo.fileStart;
            label.(nv.Name{kr}).(num2kch(kch)).fileEnd= fileInfo.fileEnd;
            label.(nv.Name{kr}).(num2kch(kch)).fileDurDn =   fileInfo.fileDurDn;
            label.(nv.Name{kr}).(num2kch(kch)).subject = eegFileContent.subject;
            label.(nv.Name{kr}).(num2kch(kch)).srcSigFile = fileInfo.srcSigFile;
        end

end



end
