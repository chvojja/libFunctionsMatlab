function git_pushFile(nv)
arguments
    nv.file_name (1,:) char
    nv.remote_folder (1,:) char
end

  sys_commands{1} = ['!git add ' nv.remote_folder '/' nv.file_name '.m' ];
  system(sys_commands{1});

end

