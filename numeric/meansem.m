function [meandata,semdata] = meansem(data)
%% MEANSEM Returns mean and sem in a scientific way
% Rounding method of digit "5" depends, it can be up, down, even, random. There is no hard standard.
% In IEEE 754, there is a recomendation to use rounding toward even because statistically it produces lower error through multiple roundings 
% In this case:   11.5 = 12; 12.5=12.
% https://blogs.mathworks.com/cleve/2021/02/25/round-with-ties-to-even/


switch nargin
    case 1
        sigDigits = 2;

    case 2

    case 3

end


if min(size(data))==1 % to column
    data = data(:);
end

%sprintf('%.2g±%.2g  95%% CI[%.2g, %.2g]', [med cih  ci(1) ci(2)])
meandata = mean(data);
stddata = std(data);
N = size(data,1);
semdata = stddata/sqrt(N);



end