function varargout = args2cell(varargin)
%ARGS2CELL  This puts all arguments to cell arrays.
% So User can call a function like fun( par1 = 'blabla') or:  fun( par1 = {'bla1','bla2'} )
% and inside the function, the arguments will be always cells.
% example call [par1,par2,Nsets ] args2cell(nv.par1,nv.par2)

%[nv.Name,nv.Color,nv.Settings,nv.Value ] = uncell(   (cellfun(@num2cell,   varargin ,   'UniformOutput',   false))   );

varargout =  cellfun(@cellstrnum,   varargin,   'UniformOutput',   false);

% how much elements we have
N = numel(varargout);
rcmax=[0 0];
for i = 1:N
    rcmax = max(   size(varargout{1}) , rcmax  );   
end

% copy defaults
for i = 1:N
    if ~ all(size(varargout{i}) ==rcmax)
        varargout{i} = repmat( varargout{i}, rcmax(1), rcmax(2));
    end

end

varargout{end+1} = max(rcmax); % number of parameter sets


end

