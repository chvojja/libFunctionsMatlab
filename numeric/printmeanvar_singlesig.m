function y = printmeanvar_singlesig( meandata, vardata )
sigDigits = 1; % single significant figure in variability
[meanStr,varStr] = meanvar2str(meandata,vardata,sigDigits);

y = [meanStr ' ± ' varStr]

end