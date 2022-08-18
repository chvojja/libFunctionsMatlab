function fcnHandlesC = randTypeHandles(fieldsC)
%TYPEEXAMPLE Returns handles that can generate random examples of a datatype.

if nargin ==0
    fieldsC = {'string','number','rowvector','cell','array'};
end
Nf = numel(fieldsC);
fcnHandlesC = cell(Nf,1);
for i = 1:Nf
    fieldName = fieldsC{i};
    switch fieldName
        case 'string'
            fcnHandlesC{i} = @(x) randstr(1,10);
        case 'number'
            fcnHandlesC{i} = @(x) ceil(abs(200*randn(1,1)));
        case 'rowvector'
            fcnHandlesC{i} = @(x) ceil(abs(10*randn(5,1)))';
        case 'cell'
            fcnHandlesC{i} = @(x) {'ahoj','blabla', [2  5  6]};
        case 'array'
            fcnHandlesC{i} = @(x) magic(3);
    end
end


end
