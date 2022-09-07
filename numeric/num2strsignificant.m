function str = num2strsignificant(value, sig, minlength, maxlength)
% str = "sprintf(value)" except for minlength and adjusting the number of decimals. 
% if round(value) has at least sig digits, use it.
%   else: round to so many decimals that you have sig significant digits
%     (OR LESS if maxlength requires). (maxlength is used only for this purpose)
% Always: length(str) >= minlength. (Adds leading spaces if necessary.)
% Uses "fixed format", never "exponential format".
%
% N.B. What you see is correctly rounded, if rounding is used
%   (but only decimals are rounded away, as many as necessary).
%   maxlength is violated iff the integer part is longer than maxlength.
%   Matlab may add rounding errors, e.g., after 17 correct digits, so you only see them if you require too many digits.
%
% EXAMPLES: str_significant(12387654321.987, 3) = '12387654322'.
%   str_significant(0.00001238, 3) = '0.0000124'. 
%   str_significant(0.12387654321, 3) = '0.124'. sprintf('%.3g', 12.387654321) = '12.4'.
%   str_significant(-0.01289, 3, 8, 6) = '  -0.013'. % 6 = maxlength of the string, 8 = minlength
%   str_significant(0.01289, 3, 0, 6) = '0.0129'. str_significant(-35.2987, 7, 0, 6)) = '-35.30'.
%   sprintf('%.3f', 0.00001238) = '0.000'. sprintf('%.3g', 1.238) = '1.24'.
%   sprintf('%.3g', 1.238e9) = '1.24e+09'. sprintf('%.3g', 1238345.49) = '1.24e+06'.
%   sprintf('%.3g', 0.0001238) = '0.000124'. sprintf('%.3g', 0.00001238) = '1.24e-05'.
%
% value = round(value, sig, 'significant');
% %  Uncomment the above line IF YOU WANT TO ROUND ALSO THE INTEGER PART, when it is too accurate. 
if (nargin < 4)
    maxlength = 999;
    if (nargin < 3)
        minlength = 0;
    end
end
if (value==0)
    str = '0';
    return;
end
lenint = length(sprintf('%d', round(abs(value)))); % length of the integer part
lenintm = lenint + (value<0); % -"- plus 1 if minus sign
maxdec = max(maxlength-lenintm-1, 0); % lenint+point+decimals <= maxlength required.
if (value >= 1 || value <= -1)
    decimals = max(min(sig-lenint, maxdec), 0); % sig-lenint decimals needed. 
else
    Nzeros = ceil(-log10(abs(value))) - 1; % # zeros after the decimal point before the first number
    decimals = min(maxdec, sig + Nzeros);
end 
str = sprintf('%*.*f', minlength, decimals, value);