function Y = table2missing(T,nv)
%TABLE2EMPTY Summary of this function goes here
%   Detailed explanation goes here
arguments
    T;
    nv.Nrows =[];
end

[r,c] =  size(T);
if isempty(nv.Nrows)
    nv.Nrows = r;
end

VariableTypes = varfun(@class,T,'OutputFormat','cell');
Y=table('Size',[nv.Nrows c],'VariableNames',T.Properties.VariableNames,'VariableTypes',VariableTypes);



for i = 1:c
    varType = VariableTypes{i};
    varName = T.Properties.VariableNames{i};
    switch varType
        case 'cell'

        case {'double', 'single'}
%              Y(:,i)=type2missingt(varType);
             Y.(varName)(:) = NaN;
    end

end


end

