function y = table_compareFun(nv)
% This looks on a table and finds nearest row number wher is NaN  or undefined field in a certain column
% column can be specified by name (string) or order (double)
arguments
    nv.Obj=[]; 
    nv.Left=[];
    nv.Right=[];
    nv.ID  double =[]; % if ID is specified, the functions will be executed only on one row
    nv.onMissingLeftHavingRight = [];
    nv.onMissingRightHavingLeft = [];
    nv.onMissingBoth = [];
    nv.onHavingBoth = [];
    nv.onSame = [];
    nv.onDifferent = [];
    %nv.Column {string, double}; % name of the column
end


if ~isempty(nv.Obj) && isobject(nv.Obj) && ~isempty(nv.Left) && ~isempty(nv.Right) && ischar(nv.Left) && ischar(nv.Right) && isprop(nv.Obj,nv.Left) && isprop(nv.Obj,nv.Right)
    % its fine now! 
    disp('sn')
    fhandle = nv.onMissingLeftHavingRight{1};
    s = functions(fhandle);

    tableResults.Number = 352;
    fhandle(tableResults);


end

if isempty(nv.Obj) && istable(nv.Left) && istable(nv.Right) 
    % its fine now! 

    

end

y = [];

end

