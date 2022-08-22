function totalDataStruct = fields2structOverwrite(nv)
%fields2structOverwrite A Wrapper for fields2struct()
    arguments     
        nv.Sources; % struct or table row or cell array of either struct or table row 
        nv.Verbose = false;
    end

    totalDataStruct = fields2structOverwrite(Sources = nv.Sources, Verbose = nv.Verbose, OverwriteSameFields = true);
end

