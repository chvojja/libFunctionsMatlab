function y = VKJ_updateLabelFile(nv)
%VKJ_UPDATELABELFILE Updates or creates  a label file 
arguments
    nv.FilePath;
    nv.LabelStruct;
end
y = 'cool job.';


         mkdir(previousPath(nv.FilePath,0)) % create the folder if it does not exist

         if isfile(nv.FilePath)
             label = load2(nv.FilePath);
             label = structMergeOverwrite(Source=nv.LabelStruct,Target=label);
             save(nv.FilePath, 'label');
         else
            % label = struct;
            label = nv.LabelStruct;
            save(nv.FilePath, 'label');
         end

end

