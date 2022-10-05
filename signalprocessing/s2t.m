function t = s2t(s,fs)
%S2T Time vector for signal
N = length(s);
t = 0:1/fs:(N-1)/fs;
end

