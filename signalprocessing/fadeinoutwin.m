function y = fadeinoutwin(L,Lfades,fun)
%FADEINOUT Summary of this function goes here
% L ... length
% Lfades ... length of fade in - outs

wb = fun(2*Lfades)';

y = ones(1,L);
y(1:Lfades) = wb(1:Lfades);
y(end-Lfades+1:end) = wb(Lfades+1:end);




