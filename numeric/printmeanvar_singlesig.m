function [y,var_decimal] = printmeanvar_singlesig( meandata, vardata )
sigDigits = 1; % single significant figure in variability
[meanStr,varStr,var_decimal] = meanvar2str(meandata,vardata,sigDigits);

y = [meanStr ' ± ' varStr];

end