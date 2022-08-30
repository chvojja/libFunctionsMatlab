%
% Example calling:
% unpack_var = 'blabla' ; unpack;
%
% TODO 
% input vars, check overwritings...



eval(['unpack_names1 = fieldnames(' unpack_var ');']);
for unpack_i=1:length(unpack_names1)
      if isstruct(eval([unpack_var '.' unpack_names1{unpack_i} ';']))
          unpack_names2 = fieldnames(eval([unpack_var '.' unpack_names1{unpack_i} ';']));
          for unpack_j=1:length(unpack_names2)
              eval([unpack_names1{unpack_i} '_' unpack_names2{unpack_j} '=' unpack_var '.' unpack_names1{unpack_i} '.' unpack_names2{unpack_j} ';']);
          end
      else
          eval([unpack_names1{unpack_i} '=' unpack_var '.' unpack_names1{unpack_i} ';']);
      end
end

% clear the mess
clear unpack_i unpack_j unpack_var unpack_names2 unpack_names1 