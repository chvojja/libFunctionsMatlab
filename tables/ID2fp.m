function fpaths = ID2fp(IDs, pathroot,ext)
%ID2FNAMES 

%pathroot = 'D:\temp_FCD_analyza_1Full\Tied\Signal';

N = numel(IDs);
extC = cell(N,1);
extC(:) = {ext};
fnameAndExt = strcat( num2cellstr(IDs) , extC);

fpaths = fullfile( pathroot ,  fnameAndExt );
end

