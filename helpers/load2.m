function varargout = load2(varargin)
% LOAD2 The function outputs the loaded variable directly instead of returning a structure.
  
  varargout = struct2cell(load(   varargin{:}  ));
end