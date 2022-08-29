function  y  = rowfunInLoop(nv)
%ROWFUNINLOOP Evaluates a fun FirstColumnFun between x and first column of Table.
% Returns value of the second table variable on a row where the function returns true.
arguments
    nv.FirstColumnFun function_handle
    nv.x;
    nv.Table;
end

firstVarName = nv.Table.Properties.VariableNames{1};
secondVarName = nv.Table.Properties.VariableNames{2};
varTypes = varfun(@class,nv.Table,'OutputFormat','cell');

Nx = numel(nv.x);


 y=table2missing(nv.Table(:,secondVarName));
 y=y.(secondVarName);


switch varTypes{2}
    case {'cell' }
        y = cell(Nx,1);
        for i = 1:Nx
           matchesL = rowfun(@(x,y) nv.FirstColumnFun(x,nv.x(i)) , nv.Table, 'InputVariables',firstVarName,'OutputFormat','uniform');
           val = [nv.Table.(secondVarName){matchesL}];
           if ~isempty(val)
                y{i} = val;
           end
        end
    otherwise %case {'int8','int16' ,'int32' ,'int64' , 'uint8','uint16' ,'uint32' ,'uint64' , 'categorical'} 
        %y = zeros(Nx,1,varTypes{2});
        for i = 1:Nx
           matchesL = rowfun(@(x,y) nv.FirstColumnFun(x,nv.x(i)) , nv.Table, 'InputVariables',firstVarName,'OutputFormat','uniform');
           val = nv.Table.(secondVarName)(matchesL);
           if ~ isempty(val)
                y(i) = val;
           end
        end
       % y = y';

end



