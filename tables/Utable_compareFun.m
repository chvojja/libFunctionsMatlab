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


%        if different.Number
%                             o.disp2('ErrorHuge');
%                             o.sprintf2('MismatchNumber', nv.Number);
%                             return
%                 end
%                 if missing.Number==0b10
%                             o.disp2('Warning');
%                             o.sprintf2('UsingNumberByUser', nv.Number);
%                 end
%                 if same.Number
%                         o.sprintf2('MatchesNumber', nv.Number);
%                 end
%                 if missing.Number==0b01
%                          o.disp2('Warning');
%                          o.sprintf2('CouldNotVerifyNumber', NumberFoundByScanning );
%                 end
%                 if missing.Number==0b11
%                          o.disp2('ErrorHuge');
%                          o.sprintf2('UnknownNumber');
%                          return
%                 end
