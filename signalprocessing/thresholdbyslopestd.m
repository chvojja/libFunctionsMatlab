function y =thresholdbyslopestd(x,baseline_samples,margins,n)
% Thresholds a signal by multiple of its std of slope. 
% % The baseline_samples should be higher than the length of whhat you want to detect
% x ... signal to be processed
% baseline_samples ... some window over which you dont care about the slope
% margins ... this thickens the threshold edges
% n ... times baseline slope higher will be selected
% y ... logical signal, true if above treshold

x=x(:)';
diffx = diff(x);
M = movmedian( diffx , baseline_samples ) ;
diffx=diffx-M;
diffx = [0 diffx];

thr =  n*movstd(diffx,baseline_samples);

x_above_L = thr<abs(diffx);

x_above_L  = imdilate( x_above_L , ones(1,margins));

y = x_above_L ;


% x2 = x;
% x2(x_above_L)= NaN;
% 
% figurefull;
% hold on;
% plot(thr,'g');
% plot(abs(diffx),'b');
% plot(abs(diff(x)),'k');
% 
% 
% plot(x,'k');
% plot(x2,'r');



end