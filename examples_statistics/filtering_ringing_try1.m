

f = double(I);
[nx ny] = size(f);
f = uint8(f);
fftI = fft2(f,2*nx-1,2*ny-1);
fftI = fftshift(fftI);
subplot(2,2,1)
imshow(f,[]);
title('Original Image')
subplot(2,2,2)
fftshow(fftI,'log')
title('Fourier Spectrum of Image')
% Initialize filter.
filter1 = ones(2*nx-1,2*ny-1);
filter2 = ones(2*nx-1,2*ny-1);
filter3 = ones(2*nx-1,2*ny-1);
for i = 1:2*nx-1
    for j =1:2*ny-1
        dist = ((i-(nx+1))^2 + (j-(ny+1))^2)^.5;
        % Use Gaussian filter.
        filter1(i,j) = exp(-dist^2/(2*d1^2));
        filter2(i,j) = exp(-dist^2/(2*d0^2));
        filter3(i,j) = 1.0 - filter2(i,j);
        filter3(i,j) = filter1(i,j).*filter3(i,j);
    end
end
% Update image with passed frequencies
filtered_image = fftI + filter3.*fftI;
subplot(2,2,3)
fftshow(filter3,'log')
title('Frequency Domain Filter Function Image')
filtered_image = ifftshift(filtered_image);
filtered_image = ifft2(filtered_image,2*nx-1,2*ny-1);
filtered_image = real(filtered_image(1:nx,1:ny));
filtered_image = uint8(filtered_image);
subplot(2,2,4)
imshow(filtered_image,[])
title('Bandpass Filtered Image')


%%
pic = im2gray(imread('ngc6543a.jpg'));

%pic = imread('trees.tif');
pic_filtered = gaussian_highpass_filter(pic,25,true,1);



%%

 x = randn(10, 1);
 X = fft(x);
 Y = freqz(x, 1, length(x), 'whole');
 isequal(Y, X)


 %%
 h770=[];
L=50;
fs=8000;
fb=770;
h770 = (2/L)*cos(2*pi*fb*(0:L-1)/fs);
fs=8000;
ww=0:(pi/256):pi;
ff=ww/(2*pi)*fs;
H=freqz(h770,1,ww);
plot(ff,abs(H));
grid on;
xlabel('Frequency')
ylabel('Magnitude')
title('Frequency Response of h770')

%%


X = load2('D:\Google Drive - st47058\#PhD#Analysis\2022-06-27 nova analyza ripples fast ripples IEDs do clanku\IEDshit5000Hz.mat');
X = X(:);
L = numel(X);

Fs = 5000;
Fn = 5000/2;

fhc = 100/Fn;
flc = 10/Fn;

n = 4;
[b,a] = butter(n,[flc fhc],'bandpass');
Y = filtfilt(b, a, X);
S = [X Y];
FTS = fft(S)/L;
Fv = linspace(0, 1, fix(L/2)+1)*Fn;
Iv = 1:numel(Fv);

figure
subplot(2,1,1)
plot(Fv, abs(FTS(Iv,1))*2)
grid
set(gca, 'XScale','log')
title('Unfiltered signal')
subplot(2,1,2)
plot(Fv, abs(FTS(Iv,2))*2)
grid
set(gca, 'XScale','log')
title('Filtered signal')

%% Frequency response of filter - b a coefficeints
figure
freqz(b, a, 2^14, Fs)
set(subplot(2,1,1), 'XScale','log')
set(subplot(2,1,2), 'XScale','log')
title(subplot(2,1,1),'Filter Bode Plot')






%plot(fax,angle(unwrap(h)));




