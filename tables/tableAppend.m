function [Y, startRow] = tableAppend(nv)
%APPENDROWS Append rows in existing table
% assumptions:
% 1. Exactly one column is named "ID" in Target but not in the Source
% 2. All existing rows have proper ID
% 3. ID is a type of double or int64

% if input is empty cell, 
arguments
    nv.Source; % a Table with a subset of same named columns as in Target
    nv.Target; % a table with named columns
    nv.Verbose = true;
end

% switch class( nv.Target.ID )
%     case 'double'
%          isu=find(isnan(nv.Target.ID));
% 
%     case {'int8','int16' ,'int32' ,'int64' }  
%          isu=find(nv.Target.ID==0);
% end
% isu(1);
% 
% 
% Te=table('Size',[r c],'VariableNames',T2u.Properties.VariableNames,'VariableTypes',T2u.Properties.VariableTypes)
% 
%     y = [nv.Target; Tnew];


 
varsInBoth = intersect( nv.Target.Properties.VariableNames , nv.Source.Properties.VariableNames );
Tsource = nv.Source(:,varsInBoth);

if isempty(Tsource) 
        Y = nv.Target;
else
    %% Fix the case when empty cell array column is in Source but in Target there is categorical column 
    varTypes_source = varfun(@class,Tsource,'OutputFormat','cell');
    varTypes_taregt = varfun(@class,nv.Target,'OutputFormat','cell');
    for i = 1:numel(varTypes_source)
        if strcmp(varTypes_source{i},'cell')
            varName = Tsource.Properties.VariableNames{i};
            if isempty([Tsource.(varName){:}]) % is all column empty
                
                isVarNameL = isequalncell(varName,nv.Target.Properties.VariableNames);
                if strcmp( varTypes_taregt(isVarNameL), 'categorical' )
                    % need to convert it to empty cellstr to make the concatenation work
                    Tsource.(varName)(:) = {''};
                end
            end
        end
    end
            
    
    varsMissingNeeded = setdiff(nv.Target.Properties.VariableNames, varsInBoth );
    Tmissing = table2missing(nv.Target(:,varsMissingNeeded), Nrows = size(nv.Source,1));
    
    [b_hasID_Target,ID_name] = hasID(nv.Target) ;
    [b_hasID_Source,~] = hasID(nv.Source,Key = ID_name) ;
    if b_hasID_Target  && ~b_hasID_Source 
        % then automatically handle IDs
        targetNans = isnan(nv.Target.(ID_name));
        nv.Target(targetNans,:) = []; % remove columns with no ID
    
        startID = newID(nv.Target);
        if isempty(startID), startID = 1; end % in this case we are appending to an empty table
       
        Tmissing.(ID_name)=[startID:(startID+size(nv.Source,1)-1)]';
    end
    
    
    Tnew = [Tsource Tmissing ];
    % crop Target if necesary or insert ?
    [~, rTarget] = rowInit(nv.Target);
    [r,c] = size(nv.Target);
    rSource = size(nv.Source,1);
    if r-rTarget.row > rSource
            % we make a dirty trick
            % this will keep the data type of the shits consistent with the target:
            temp = [nv.Target(end,:); Tnew];
            nv.Target(rTarget.row:rTarget.row+rSource-1,:) = temp(2,:);
            Y = nv.Target;
            startRow = rTarget.row;
    else
     
            nv.Target(rTarget.row:end,:) =[];
            Y = [nv.Target; Tnew];
            startRow = size(nv.Target,1)+1; % nevim co je startRow
    
        
            %startRow = size(nv.Target,1);
        
    end
end

end

