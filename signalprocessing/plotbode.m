function  plotbode(nv)
arguments 
    %freqz way
    nv.a=[];
    nv.b=[];
    nv.Fs=[];
    % fft way
    nv.FFT=[]
    %
    nv.Magnitude=[];
end


if all( arenotempty(nv.b,nv.a,nv.Fs) )
    %Frequency response of filter - b a coefficeints 
    figurefull;
%     bodeplot(tf(nv.b,nv.a) , 'FreqUnits','Hz' )

    [h,fax] = freqz(nv.b, nv.a, 2^13, nv.Fs);
    plot(fax,20*log10(abs(h)));
    grid;
    ax = gca;
    %ax.XLim = [min(fax) max(fax)];
    ax.YLim = [-60 20];
    ax.XScale = 'log';
    %ax.XTick = 0:.5:2;
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
end



if all( arenotempty(nv.FFT,nv.Fs) )
    figurefull;

    fftoutput = nv.FFT;
    fs = nv.Fs;

    Fn = fs/2;
    
    L = numel(fftoutput);
    FTS = fftoutput/L;
    Fv = linspace(0, 1, fix(L/2)+1)*Fn;
    Iv = 1:numel(Fv);
    
    
    plot(Fv, 20*log10( abs(FTS(Iv))*2   )   );
    grid
    
    ax = gca;
    %ax.XLim = [min(fax) max(fax)];
    ax.YLim = [-60 20];
    ax.XScale = 'log';
    %ax.XTick = 0:.5:2;
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
end



if all( arenotempty(nv.Magnitude,nv.Fs) )
    figurefull;


    Fn = nv.Fs/2;
   
    L = numel(nv.Magnitude);
    Fv = linspace(0+eps, 1, L)*Fn;

    plot(Fv, 20*log10( nv.Magnitude   )   );
    grid
    
    ax = gca;
    %ax.XLim = [min(F
    % v) max(Fv)];
    ax.YLim = [-60 20];
   % ax.XScale = 'log';
    %ax.XTick = 0:.5:2;
    xlabel('Frequency (Hz)')
    ylabel('Magnitude (dB)')
end


