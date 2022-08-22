function rowNumber = nextRow(nv)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
arguments 
    nv.Table table
    nv.KeyColumn = [];
end

if isempty(nv.KeyColumn)
    missingL = ismissingt(nv.Table);


else
    isu = find(ismissing(nv.Table.(nv.KeyColumn))); 
    rowNumber = isu(1);
end

