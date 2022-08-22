function totalDataStruct = fields2struct(nv)
%fields2struct Puts fields from different sources into a single structure
%   nv.Sources can be: 1) a cell array of structs or table row 
%   or 2) just a struct with fileds (trivial case)
    arguments     
        nv.Sources; % struct or table row or cell array of either struct or table row 
        nv.OverwriteSameFields = false;
        nv.Verbose = false;

    end

    totalDataStruct = struct;
    if iscell(nv.Sources)
        Ns = numel(nv.Sources);
            for ns = 1:Ns
                src = nv.Sources{ns};
                className = class(src);
                switch  className  % convert if necessary
                    case 'table'
                        src = table2struct(src);
                    case 'struct'

                end
                totalDataStruct = mergeStructs(Source = src,Target = totalDataStruct, OverwriteSameFields = nv.OverwriteSameFields);
                % if nv.OverwriteSameFields true, this will update the first structure with the next and the next and the next one....
            end    
    else
        if isstruct(nv.Sources)
            totalDataStruct = nv.Sources;
        end
    end
end

