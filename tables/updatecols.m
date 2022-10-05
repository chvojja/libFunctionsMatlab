function Tdest = updatecols(Tsource,Tdest)
%UPDATECOLS Updates table columns with something


%NvarsDest = Tdest.Properties.VariableNames;
varsInBoth = intersect( Tdest.Properties.VariableNames , Tsource.Properties.VariableNames);
varsNotInDest = setdiff( Tsource.Properties.VariableNames , Tdest.Properties.VariableNames);

for i = 1:numel(varsInBoth)

    Tdest.(varsInBoth{i}) = Tsource.(varsInBoth{i});

end

for i = 1:numel(varsNotInDest)

    Tdest.(varsNotInDest{i}) = Tsource.(varsNotInDest{i});

end