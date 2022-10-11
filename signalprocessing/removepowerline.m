function y = removepowerline(x,fs)
y = x;
shitfactor = 0.1;
fac = 50;

flist = [fac:fac:(fac*floor(fs/2/fac) -fac )];

flist = flist(1:8);

for f = flist

phi =2*pi*f/fs;

mag = 1 ;
z = [ mag*exp(1i*phi); mag*exp(-1i*phi)  ];
mag = 0.998;
p = [ mag*exp(1i*phi); mag*exp(-1i*phi)  ];

k = 1;
[b,a] = zp2tf(z,p,k);

%fvtool(b,a,'polezero')

x = filtfilt(b,a,x);


end


y = 0.8*x+0.2*y;
%y = x;




end