
function im_2 = filtergauss(nv)
%% FILTERGAUSS This filteres a signal or image by gaussian filter in order to reduce ringing artefacts.
% Its zero phase (as if it was filtered by filtfilt) because the response of the filter is real (?)

arguments 
    nv.X;
    nv.HighPass = [];
    nv.LowPass = [];
    nv.BandPass = [];

    nv.N = 1;
end


filterType = onehotfun( {nv.HighPass,nv.LowPass, nv.BandPass} , {'HP','LP','BP'}   );

y_over_x_scale_factor = nv.N;
show_freq_domain = false;

 num_rows = size(nv.X,1);
    num_cols = size(nv.X,2);
    [X,Y] = meshgrid(1:num_cols,1:num_rows);
    freq_domain = fft2(nv.X);
    freq_domain_shifted=fftshift(freq_domain);
    freq_pass_window = ones(size(nv.X));
    freq_pass_window_center_x = floor(size(freq_pass_window,2)/2)+1;
    freq_pass_window_center_y = floor(size(freq_pass_window,1)/2)+1;


switch filterType
    case 'HP'
        low_freq = nv.HighPass;
        gauss_filter = 1-exp(-4*log(2)*(X-freq_pass_window_center_x).^2/(2*low_freq)^2) .* exp(-4*log(2)*(Y-freq_pass_window_center_y).^2/(2*low_freq)^2/y_over_x_scale_factor^2);
    case 'LP'
        high_freq = nv.LowPass;
%         gauss_filter = exp(-4*log(2)*(X-freq_pass_window_center_x).^2/(2*high_freq)^2) .* exp(-4*log(2)*(Y-freq_pass_window_center_y).^2/(2*high_freq)^2/y_over_x_scale_factor^2);
        gauss_filter = exp(-4*log(2)*(X-freq_pass_window_center_x).^2/(2*high_freq)^2) .* exp(-4*log(2)*(Y-freq_pass_window_center_y).^2/(2*high_freq)^2/y_over_x_scale_factor^2);
    % TODO make it with defined attenuation
        % in time domain
%         stdev = (N-1)/(2*alpha);
%          y = exp(-1/2*(n/stdev).^2);
% in freq domain 
% ydft = exp(-1/2*(freq/(1/stdev)).^2)*(stdev*sqrt(2*pi));

    case 'BP'
        sc = -4*log(2) * nv.N;
        low_freq = nv.BandPass(1);
        gauss_filterHP = 1-exp(sc*(X-freq_pass_window_center_x).^2/(2*low_freq)^2) .* exp(sc*(Y-freq_pass_window_center_y).^2/(2*low_freq)^2/y_over_x_scale_factor^2);
       
        high_freq = nv.BandPass(2);
        gauss_filterLP = exp(sc*(X-freq_pass_window_center_x).^2/(2*high_freq)^2) .* exp(sc*(Y-freq_pass_window_center_y).^2/(2*high_freq)^2/y_over_x_scale_factor^2);

        gauss_filter = gauss_filterHP.*gauss_filterLP;



end
    gauss_filter =  mat2gray(gauss_filter);
%     plotbode(Magnitude = gauss_filter(2500:end), Fs =5000);
%     pause

    freq_pass_window = freq_pass_window.*gauss_filter;

    windowed_freq_domain_shifted = freq_domain_shifted.*freq_pass_window;
    adjusted_freq_domain = ifftshift(windowed_freq_domain_shifted);
    im_2 = ifft2(adjusted_freq_domain);
    if show_freq_domain
        figure, imagesc(nv.X);
        title('Original image');
%         figure, imagesc(freq_pass_window);
%         title('Filter');
%         figure, imagesc(log10(abs(freq_domain_shifted)));
%         title('log_1_0(Original frequency domain)');
%         figure, imagesc(log10(abs(windowed_freq_domain_shifted)));
%         title('log_1_0(Filtered frequency domain)');
%         figure, imagesc(abs(freq_domain_shifted));
%         title('Original frequency domain');
%         figure, imagesc(abs(windowed_freq_domain_shifted));
%         title('Filtered frequency domain');


        figure, imagesc(im_2);
        title('Filtered image');
    end
end
