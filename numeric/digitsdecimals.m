function [digits,decimal,numChar] = digitsdecimals(x)

%% Warning! This is in attempt to support exponential notation, but it does not work with:

%d.mean=0.00001154; d.sem = 0.0000002;
%d.mean=135; d.sem = 18; % 140+-20
% please x has to be NOT in exponential form

 xChar = x;
 dot_pos = find( xChar == '.') ;
 e_pos = find( xChar == 'e' | xChar == 'E'  ) ;
 if ~isempty( e_pos )
    
    multiplier_if_exp_notation = str2num( xChar(e_pos+1:end) );
    
    xChar(e_pos:end)=[];

    numChar = [xChar repmat('0',1,multiplier_if_exp_notation) ]; % this line is wrong! this should be prepared on 1.2e-5 or 1e2 or others.
    % this should move the decimal point left right according to the exponent. This is wrong

 else
     numChar = x;
    multiplier_if_exp_notation = 0;
 end



if isempty( dot_pos )
    digits =  length(xChar) + multiplier_if_exp_notation;
    decimal = -digits +1;    
else
    NbeforeDec = numel(xChar(1:dot_pos-1));
    for i = 1:NbeforeDec
             if xChar(i)~='0'
                  digits_beforedecimal=NbeforeDec-i+1;
                  digits_afterdecimal = length(xChar) - NbeforeDec -1;
                  correction_if_exp = double(    abs((  multiplier_if_exp_notation-digits_afterdecimal ))*( multiplier_if_exp_notation-digits_afterdecimal )>0   );
                  digits = digits_beforedecimal + digits_afterdecimal + correction_if_exp;
                  decimal=digits_afterdecimal + correction_if_exp;
                 return
             end
    end
    NafterDec = numel(xChar(dot_pos+1:end));
    for i = dot_pos+1 : length(xChar) 
             if xChar(i)~='0'
                  digits_beforedecimal=0;
                  digits_afterdecimal = length(xChar)  - i+1;
                  digits = digits_beforedecimal + digits_afterdecimal;
                  decimal=  (length(xChar) -dot_pos );
                 return
             end
    end
end


end