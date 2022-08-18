function y = randStructMixed(Nfields)
%TYPEEXAMPLE Generates random example of a datatype = structure with mixed payload
fieldNamesC = {'string','number','rowvector','cell','array'};
fcnHandlesC = randTypeHandles(fieldNamesC);

if nargin ==0
    Nfields = 3;
end

for i = 1:Nfields
    Idx = mod(i-1,numel(fieldNamesC))+1;
    fcnh = fcnHandlesC{Idx};
    fName = [fieldNamesC{Idx} num2str(ceil(abs(10000000*randn(1)))) ] ;
    y.(fName)  =  fcnh();
end


end
