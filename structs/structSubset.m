function Y = structSubset(S, FieldList, Condition)
%STRUCTSUBSET Summary of this function goes here
%   S may be a structure array
switch nargin   
    case 2
        for iField = 1:numel(FieldList)
           Field    = FieldList{iField};
           if isfield(S,Field)
               for k = 1:numel(S)
                    Y(k).(Field) = S(k).(Field);
               end
           end
        end
    case 3 
         for iField = 1:numel(FieldList)
            Field    = FieldList{iField};
            if isfield(S,Field)
               for k = 1:numel(S)
                    Y(k).(Field) = S(k).(Field)(Condition);
               end
            end
         end
end


