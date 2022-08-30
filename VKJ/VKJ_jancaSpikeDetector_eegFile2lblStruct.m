function label=VKJ_jancaSpikeDetector_eegFile2lblStruct(nv)
arguments
    nv.FilePath;
    nv.Name = 'JancaSpikeDetectorDefault';
    nv.Color = '1 0 0';
    nv.Settings = [];
    nv.Value = 5;
end



nv.FilePath = char(nv.FilePath);
eegFileContent = load(nv.FilePath);
N=size(eegFileContent.s,2);
if isempty(nv.Settings)
    out = spike_detector_hilbert_v23(eegFileContent.s',eegFileContent.fs);
else
    out = spike_detector_hilbert_v23(eegFileContent.s',eegFileContent.fs,nv.Settings); %-w 25000 -n 10000');
end

label = struct;
label.(nv.Name).name = nv.Name;
label.(nv.Name).color = nv.Color;
label.(nv.Name).instant = false;
label.(nv.Name).chanNames = eegFileContent.chanNames;
label.(nv.Name).subject = eegFileContent.subject;
label.(nv.Name).fileStart =  datestr(eegFileContent.dateN);

endDn = eegFileContent.dateN + sec2dn(N/eegFileContent.fs);
label.(nv.Name).fileEnd = datestr( endDn );
label.(nv.Name).fileDurDn = endDn-eegFileContent.dateN;


[~,eegFileName,ext] = fileparts(nv.FilePath);
label.(nv.Name).srcSigFile = [eegFileName ext];

chans=unique(out.chan);
for kch = chans' %1:numel(chans)
%     chOne=chans(kch);
%     idx=out.chan==chOne;

    idx=out.chan==kch;
    label.(nv.Name).(num2kch(kch)).posN=eegFileContent.dateN+sec2dn(out.pos(idx))';
    label.(nv.Name).(num2kch(kch)).durN=sec2dn(out.dur(idx)');
    label.(nv.Name).(num2kch(kch)).value=[nv.Value*ones(1,numel(find(idx)))];
    
    % debilni hodnoty pro kudljze
    label.(nv.Name).(num2kch(kch)).chan=kch;
    label.(nv.Name).(num2kch(kch)).chanType=1;
    % debilni hodnoty pro me
    label.(nv.Name).(num2kch(kch)).ChName=eegFileContent.chanNames{kch};
    label.(nv.Name).(num2kch(kch)).fileStart=label.(nv.Name).fileStart;
    label.(nv.Name).(num2kch(kch)).fileEnd=label.(nv.Name).fileEnd;
    label.(nv.Name).(num2kch(kch)).fileDurDn =    label.(nv.Name).fileDurDn;
    label.(nv.Name).(num2kch(kch)).subject = eegFileContent.subject;
    label.(nv.Name).(num2kch(kch)).srcSigFile = label.(nv.Name).srcSigFile;
end





end