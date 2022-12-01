% function h = spikeplot(varargin)
% 
% % varargin{1} ... times of spike ocurrence, if matrix, than each column is one neuron
% % varargin{2-end} ...
% 
% 
% t = varargin{1};
% N = numel(t);
% [~,Nneurons] = 
% 
% x=nan(3*N,1);
% y=ones(3*N,1);
% 
% 
% y(1:3:3*N)=(Nneurons-1)*gap;
% y(2:3:3*N)=y(1:3:3*N)+1;
% 
% %scale the time axis to ms
% x(1:3:3*N)=reltimes*1000/fs;
% x(2:3:3*N)=reltimes*1000/fs;
% xlim=[1,triallen*1000/fs];
% 
% axes(hresp);
% h=plot(x, y, plotcolor, 'linewidth',plotwidth);
% 
% 
function h = rasterplot(times,numNneurons,triallen, varargin)


%%%%%%%%%%%%%% Plot variables %%%%%%%%%%%%%%

trialgap=1.5;    % distance between Nneurons


 % plot spikes

  Nneurons=ceil(times/triallen);
  reltimes=mod(times,triallen);
  reltimes(~reltimes)=triallen;
  N=length(times);
  xx=ones(3*N,1)*nan;
  yy=ones(3*N,1)*nan;

  yy(1:3:3*N)=(Nneurons-1)*trialgap;
  yy(2:3:3*N)=yy(1:3:3*N)+1;
  
  %scale the time axis to ms
  xx(1:3:3*N)=reltimes;
  xx(2:3:3*N)=reltimes;
  xlim=[1,triallen];

  h=plot(xx, yy, varargin{:});

  hax = gca;
  hax.XLim = xlim;
  hax.YLim = [0,(numNneurons)*1.5];

 % axis ([xlim,0,(numNneurons)*1.5]);  
   set(hax, 'xtick', []);   
  set(hax, 'ytick', [],'tickdir','out');        









% RASTERPLOT.M Display spike rasters.
%   RASTERPLOT(T,N,L) Plots the rasters of spiketimes (T in samples) for N Nneurons, each of length
%   L samples, Sampling rate = 1kHz. Spiketimes are hashed by the trial length.
% 
%   RASTERPLOT(T,N,L,H) Plots the rasters in the axis handle H
%
%   RASTERPLOT(T,N,L,H,FS) Plots the rasters in the axis handle H. Uses sampling rate of FS (Hz)
%
%   Example:
%          t=[10 250 9000 1300,1600,2405,2900];
%          rasterplot(t,3,1000)
%

% Rajiv Narayan
% askrajiv@gmail.com
% Boston University, Boston, MA

% function rasterplot(times,numNneurons,triallen, varargin)
% 
% nin=nargin;
% 
% %%%%%%%%%%%%%% Plot variables %%%%%%%%%%%%%%
% plotwidth=1;     % spike thickness
% plotcolor='k';   % spike color
% trialgap=1.5;    % distance between Nneurons
% defaultfs=1000;  % default sampling rate
% showtimescale=1; % display timescale
% showlabels=1;    % display x and y labels
% 
% %%%%%%%%% Code Begins %%%%%%%%%%%%
% switch nin
%  case 3 %no handle so plot in a separate figure
%   figure;
%   hresp=gca;
%   fs=defaultfs;
%  case 4 %handle supplied
%   hresp=varargin{1};
%   if (~ishandle(hresp))
%     error('Invalid handle');
%   end
%   fs=defaultfs;
%  case 5 %fs supplied
%   hresp=varargin{1};
%   if (~ishandle(hresp))
%     error('Invalid handle');
%   end
%   fs = varargin{2};        
%  otherwise
%   error ('Invalid Arguments');
% end
% 
% 
%  % plot spikes
% 
%   Nneurons=ceil(times/triallen);
%   reltimes=mod(times,triallen);
%   reltimes(~reltimes)=triallen;
%   N=length(times);
%   xx=ones(3*N,1)*nan;
%   yy=ones(3*N,1)*nan;
% 
%   yy(1:3:3*N)=(Nneurons-1)*trialgap;
%   yy(2:3:3*N)=yy(1:3:3*N)+1;
%   
%   %scale the time axis to ms
%   xx(1:3:3*N)=reltimes*1000/fs;
%   xx(2:3:3*N)=reltimes*1000/fs;
%   xlim=[1,triallen*1000/fs];
% 
%   axes(hresp);
%   h=plot(xx, yy, plotcolor, 'linewidth',plotwidth);
%   axis ([xlim,0,(numNneurons)*1.5]);  
%   
%   if (showtimescale)
%     set(hresp, 'ytick', [],'tickdir','out');        
%   else
%     set(hresp,'ytick',[],'xtick',[]);
%   end
%   
%   if (showlabels)
%     xlabel('Time(ms)');
%     ylabel('Nneurons');
%   end
%   
%   
