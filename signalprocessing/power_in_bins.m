function [power_bins] = power_in_bins(x, fs, fbins)
%     N = length(x);
%     X = fft(x);
%     X_mag = abs(X);
%     X_power = X_mag.^2;
%     bin_size = fs/N;
%     bin_indices = round(fbins/bin_size);
%     power_bins = zeros(size(fbins));
%     for i = 1:(length(fbins)-1)
%         power_bins(i) = sum(X_power(bin_indices(i):bin_indices(i+1)));
%     end


    N = length(x);
    xdft = fft(x);
    xdft = xdft(1:N/2+1);
    psdx = (1/(fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    freq = 0:fs/length(x):fs/2;

    Nf = (length(fbins)-1);
    power_bins = zeros(Nf,1);
    bin_size = fs/N;
    bin_indices = round(fbins/bin_size)+1;  
    for i = 1:Nf
        fcenter_bins(i) = ( fbins(i+1) + fbins(i) )/2;
        power_bins(i) = sum(psdx(bin_indices(i):(bin_indices(i+1)-1)));
    end 
    subplot(2,1,1);
    stem(freq,psdx)
    subplot(2,1,2);
    stem(fcenter_bins,power_bins);

end