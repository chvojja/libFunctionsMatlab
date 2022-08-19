function y = mergeStructs(nv)
% nv is property value pairs
% % Example use
% struct1.a=1;
% struct1.b=2;
% struct2.blabla='asdadfxf';
% struct2 = copy_struct_fields(src = struct1,dest = struct2,fields={'a','b'})
% struct2 = copy_struct_fields(someSettingsStructure) % second possible call

arguments
   nv.Source (1,1) struct 
   nv.Target (1,1) struct
   nv.Fields (1,:) cell = [];
   nv.Overwrite = true;
   nv.Verbose (1,1) logical = false;
end

if isempty(nv.Fields) % copy all by default
    nv.Fields = fieldnames(nv.Source);
end

% Code
Nf=numel(nv.Fields);
if nv.Verbose, disp2(nv.Verbose, ['Im going to copy ' num2str(Nf) ' fields.' ]); end;

for i = 1:Nf
    field_name = nv.Fields{i};
    b_hasSameField = isfield(nv.Target,field_name);
    if b_hasSameField
        if nv.Overwrite 
            b_canWrite = true;
        else
            b_canWrite = false;
            if nv.Verbose, disp2(nv.Verbose, ['A field ' field_name ' is already in the Target structure. I did not overwrite it.' ]); end;
        end
    else
        b_canWrite = true;
    end

    if b_canWrite
        nv.Target.(field_name) = nv.Source.(field_name);
    end
    
end
y = nv.Target;
end