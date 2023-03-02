function varargout = plotfs(varargin)
%PLOTFS Wrapper around plot
y = varargin{1};
fs = varargin{2};
[Nsamples,Ntraces] = size(y);
if Nsamples == 1 & Ntraces>1
    y = y';
    Nsamples = Ntraces;
    Ntraces = 1;
end

x = 0:1/fs:(Nsamples-1)/fs;
x = repmat(x',1,Ntraces);
varargout = plot(x,y,varargin{3:end});
varargout = {varargout};
end

