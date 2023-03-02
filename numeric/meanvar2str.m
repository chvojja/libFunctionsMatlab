function [meanStr,varStr] = meanvar2str(meandata,vardata,sigDigits)
%% MEANVAR2STR Returns mean and sem in a scientific way
% this somehow works but it is not optimized in any way

% Rounding method of digit "5" depends, it can be up, down, even, random. There is no hard standard.
% In IEEE 754, there is a recomendation to use rounding toward even because statistically it produces lower error through multiple roundings 
% In this case:   11.5 = 12; 12.5=12.
% https://blogs.mathworks.com/cleve/2021/02/25/round-with-ties-to-even/

%% TODO it does not work properly

switch nargin
    case 1
        
    case 2
        sigDigits = 1;
    case 3
end

%semdata = round(semdata,sigDigits,'significant');

%      if roundDigit<0
    %meanStr = num2str( round(meandata, -roundDigit+sigDigits ) ); 
    %devdata  = round(devdata , sigDigits ,'significant') ;
%         devStr =num2str(devdata,sigDigits);
 varStr = sprintf(['%.' num2str(sigDigits) 'g'], vardata ); % this might be in scientific notation like  '1.1e+02' or '0.045' or even loose sign. digit '0.04'

 e_pos = find(  varStr == 'e' |  varStr == 'E'  ) ; % this is dirty trick - if it outputs the exponential form, it will make it print  normal but it is dirty
 if ~isempty( e_pos )
    varStr = regexprep( sprintf('%.20f', str2num( sprintf(['%.' num2str(sigDigits) 'g'], vardata ) ) ), '0+$', '', 'lineanchors');
     if strcmp( varStr(end), '.')
        varStr(end) = [];
     end
 end



 [var_digits,var_decimal,varStr] = digitsdecimals(varStr);



 %sigDigits  = min(sigDigitsNew, sigDigits ); % probably not needed


meandata = round(meandata, var_decimal ) ;
if var_decimal<0 % we have scientific notation in devStr
 var_decimal = 0;
end
meanStr = sprintf(['%.' num2str( var_decimal ) 'f'], meandata );  % '%.4f'

%sprintf(['%.' num2str(sigDigits) 'g±%.' num2str(sigDigits) 'g'], [mean(data(:,i))  std(data(:,i))/sqrt(numel(data(:,i)))])









end