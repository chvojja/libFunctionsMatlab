function y = tableNewEmpty(ColumnName,DataType,nv)
% % Example use
% Nrows = 10;
% Tmytable = table_createEmpty(Nrows,'ID','double','Subject','cat','Number','double','Treatment','cat','Role','cat'); % one row per subject    
% cat = categorical
% logi = logical


arguments (Repeating)
   ColumnName %  a valid name
   DataType   % 'double','categorical','cell', char ,'logical',
end
arguments
   nv.Nrows = 0;
end
    
% Code
varNamesAsCell = ColumnName;

I_is_cat = find(contains(DataType,'cat'));
DataType(I_is_cat) = {'categorical'};
I_is_logi = find(contains(DataType,'logi'));
DataType(I_is_logi) = {'logical'};

varTypesAsCell = DataType;

y = table('Size',[nv.Nrows,numel(varNamesAsCell)],'VariableTypes',varTypesAsCell,'VariableNames',varNamesAsCell);

% fill with NaNs if necessary
I_is_double = find(contains(DataType,'double'));
for i=I_is_double
     y{:,i}=NaN(nv.Nrows,1);
end
end