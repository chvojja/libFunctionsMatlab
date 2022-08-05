function y = table_createEmpty(Nrows,ColumnName,DataType)
% % Example use

arguments
   Nrows = 0;
end

arguments (Repeating)
   ColumnName %  a valid name
   DataType   % 'double','categorical','cell', char ,'logical',
end
    
% Code
varNamesAsCell = ColumnName;

I_is_cat = find(contains(DataType,'cat'));
DataType(I_is_cat) = {'categorical'};
I_is_logi = find(contains(DataType,'logi'));
DataType(I_is_logi) = {'logical'};

varTypesAsCell = DataType;

y = table('Size',[Nrows,numel(varNamesAsCell)],'VariableTypes',varTypesAsCell,'VariableNames',varNamesAsCell);

% fill with NaNs if necessary
I_is_double = find(contains(DataType,'double'));
for i=I_is_double
     y{:,i}=NaN(Nrows,1);
end
end