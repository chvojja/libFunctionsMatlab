function varargout = printmeansem(meandata,semdata,sigDigits)
%% MEANSEM Returns mean and sem in a scientific way
% Rounding method of digit "5" depends, it can be up, down, even, random. There is no hard standard.
% In IEEE 754, there is a recomendation to use rounding toward even because statistically it produces lower error through multiple roundings 
% In this case:   11.5 = 12; 12.5=12.
% https://blogs.mathworks.com/cleve/2021/02/25/round-with-ties-to-even/

%% TODO it does not work properly


switch nargin
    case 1
        

    case 2
        sigDigits = 2;

    case 3

end


%semdata = round(semdata,sigDigits,'significant');
devdata = semdata;
devMeasure = ' (SEM)';

Nout = size(meandata,2);
varargout = cell(Nout,1);
for i = 1: Nout
   
     roundDigit = ceil(log10( devdata(i) +eps ));
       roundDigit = ceil(log10( devdata(i) ));
%      if roundDigit<0
        %meanStr = num2str( round(meandata(i), -roundDigit+sigDigits ) ); 
        %devdata(i)  = round(devdata(i) , sigDigits ,'significant') ;
%         devStr =num2str(devdata(i),sigDigits);
     devStr = sprintf(['%.' num2str(sigDigits) 'g'], devdata(i) ); % this might be in scientific notation like  '1.1e+02' or '0.045' or even loose sign. digit '0.04'
    

     [dev_digits,dev_decimal] = nsigdigits(devStr);

     if dev_decimal<0 % we have scientific notation in devStr
         dev_decimal = 0;
     end
     %sigDigits  = min(sigDigitsNew, sigDigits ); % probably not needed


        meandata(i) = round(meandata(i), dev_decimal ) ;
        meanStr = sprintf(['%.' num2str( dev_decimal ) 'f'], meandata(i) );  % '%.4f'

    varargout{i} = [ meanStr ' � '  devStr devMeasure ];
    %sprintf(['%.' num2str(sigDigits) 'g�%.' num2str(sigDigits) 'g'], [mean(data(:,i))  std(data(:,i))/sqrt(numel(data(:,i)))]);
end





end