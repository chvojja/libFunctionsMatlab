function y = table_createEmptyByExample(Nrows,ColumnName,DataExample)
% % Example use
% Nrows = 10;
% Tmytable = table_createEmpty(Nrows,'ID',1,'Subject',rat1','Number',5,'Treatment','shitovacka'); % one row per subject    
% cat = categorical
% logi = logical
arguments
   Nrows = 0;
end

arguments (Repeating)
   ColumnName %  a valid name
   DataExample   % 'double','categorical','cell', char ,'logical',
end
    
% Code
varNamesAsCell = ColumnName;

% get class of each example
Nvar = numel(DataExample);
fillWithNaNs = false(Nvar,1);
varTypesAsCell = cell(1,Nvar);
for i=1:Nvar
    varTypesAsCell{i} = class(DataExample{i});
    switch varTypesAsCell{i}
        case 'char'
            varTypesAsCell{i}='categorical';
        case 'double'
            fillWithNaNs(i) = true;
        otherwise 
            
    end
end

% create table
y = table('Size',[Nrows,numel(varNamesAsCell)],'VariableTypes',varTypesAsCell,'VariableNames',varNamesAsCell);

% fill with NaNs if necessary
for i=1:Nvar
    if fillWithNaNs(i)
        y{:,i}=NaN(Nrows,1);
    end
end
end