function y = mergeStructsOverwrite(nv)
% mergeStructsOverwrite is a wriapper for mergeStructs

arguments
   nv.SourceStruct (1,1) struct 
   nv.TargetStruct (1,1) struct
   nv.Fields (1,:) cell = [];
   nv.Verbose (1,1) logical = false;
end

y = mergeStructs(SourceStruct = nv.SourceStruct, TargetStruct =nv.TargetStruct,Fields=nv.Fields, OverwriteSameFields = true, Verbose = nv.Verbose);

end