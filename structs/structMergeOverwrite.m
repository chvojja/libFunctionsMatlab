function y = structMergeOverwrite(nv)
% mergeStructsOverwrite is a wriapper for mergeStructs

arguments
   nv.Source (1,1) struct 
   nv.Target (1,1) struct
   nv.Fields (1,:) cell = [];
   nv.Verbose (1,1) logical = false;
end

y = structMerge(Source = nv.Source, Target =nv.Target,Fields=nv.Fields, OverwriteSameFields = true, Verbose = nv.Verbose);

end