function y = filterfft2(x,magnitude_vector)
% From signal x of N points generates spectrum by fft2()
% Then, it applies magnitude vector of N points on the spectrum.


x=x(:);
% num_rows = size(x,1);
% num_cols = size(x,2);
%[X,Y] = meshgrid(1:num_cols,1:num_rows);
freq_domain = fft2(x);
freq_domain_shifted=fftshift(freq_domain);
freq_pass_window = ones(size(x));
% freq_pass_window_center_x = floor(size(freq_pass_window,2)/2)+1;
% freq_pass_window_center_y = floor(size(freq_pass_window,1)/2)+1;


freq_pass_window = freq_pass_window.*magnitude_vector;

% plotbode(Magnitude = mag_filter(2500:end), Fs =5000);
% pause

windowed_freq_domain_shifted = freq_domain_shifted.*freq_pass_window;
adjusted_freq_domain = ifftshift(windowed_freq_domain_shifted);
im_2 = ifft2(adjusted_freq_domain);
y = im_2;

end