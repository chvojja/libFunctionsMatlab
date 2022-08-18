function y = randstr(r,c)
%RANDS Generates random string of size (r,c)

an=double('a');
zn=double('z');

y=char(randi([an zn],r,c));


end

