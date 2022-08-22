function y = mergeStructs(nv)
% mergeStructs Adds fields from SourceStruct among the fields of the TargetStruct
% nv is property value pairs
% % Example use
% struct1.a=1;
% struct1.b=2;
% struct2.blabla='asdadfxf';
% struct2 = copy_struct_fields(src = struct1,dest = struct2,fields={'a','b'})
% struct2 = copy_struct_fields(someSettingsStructure) % second possible call

arguments
   nv.SourceStruct (1,1) struct 
   nv.TargetStruct (1,1) struct
   nv.Fields (1,:) cell = [];
   nv.OverwriteSameFields = false;
   nv.Verbose (1,1) logical = false;
end

if isempty(nv.Fields) % copy all by default
    nv.Fields = fieldnames(nv.SourceStruct);
end

% Code
Nf=numel(nv.Fields);
if nv.Verbose, disp2(nv.Verbose, ['Im going to copy ' num2str(Nf) ' fields.' ]); end;

for i = 1:Nf
    field_name = nv.Fields{i};
    b_hasSameField = isfield(nv.TargetStruct,field_name);
    if b_hasSameField
        if nv.OverwriteSameFields 
            b_canWrite = true;
        else
            b_canWrite = false;
            if nv.Verbose, disp2(nv.Verbose, ['A field ' field_name ' is already in the Target structure. I did not overwrite it.' ]); end;
        end
    else
        b_canWrite = true;
    end

    if b_canWrite
        nv.TargetStruct.(field_name) = nv.SourceStruct.(field_name);
    end
    
end
y = nv.TargetStruct;
end