function  tablesRowFun(T1,T2,fhandle,nv)
%TABLESTESTINGROWFUN Summary of this function goes here
%   Detailed explanation goes here
arguments
    T1
    T2
    fhandle
    nv.TestWhat = [];
    nv.TestWhere = [];
end

rowsT1=size(T1); rowsT2=size(T2);
if rowsT1 == rowsT2
    Nrows = rowsT1;
else
    disp('wrong size of tables')
    return
end

if ~isempty(nv.TestWhere)
    Ncols = numel(nv.TestWhere);
    if isempty(nv.TestWhat)
        disp('wrong arguments')
        return
    end
end



for row = 1:Nrows
    pv.Table(row,:) = pv.Function(pv.Table(row,:));
end


end

