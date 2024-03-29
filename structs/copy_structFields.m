function y = copy_structFields(pv)
% pv is property value pairs
% % Example use
% struct1.a=1;
% struct1.b=2;
% struct2.blabla='asdadfxf';
% struct2 = copy_struct_fields(src = struct1,dest = struct2,fields={'a','b'})
% struct2 = copy_struct_fields(someSettingsStructure) % second possible call

arguments
   pv.src (1,1) struct = []; 
   pv.dest (1,1) struct = [];
   pv.fields (1,:) cell = [];
   pv.verbose (1,1) logical = false;
end
    
% Code
Nf=numel(pv.fields);
if pv.verbose, disp(['Im going to copy ' num2str(Nf) ' fields.' ]); end;

for i = 1:Nf
    field_name = pv.fields{i};
    pv.dest.(field_name) = pv.src.(field_name);
end
y = pv.dest;
end