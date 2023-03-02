d.mean=31.25; d.sem = 0.034953; % should be 31.25+-0.03
printmeanvar_singlesig( d.mean, d.sem )

%%

d.mean=1261.29; d.sem = 213; % should be 1300+-200
printmeanvar_singlesig( d.mean, d.sem )

d.mean=1261.29; d.sem = 200;
printmeanvar_singlesig( d.mean, d.sem )

d.mean=135; d.sem = 18; % 140+-20
printmeanvar_singlesig( d.mean, d.sem )

d.mean=135; d.sem = 8; % 140+-20
printmeanvar_singlesig( d.mean, d.sem )

d.mean=0.05; d.sem = 2.5143; % 
printmeanvar_singlesig( d.mean, d.sem )
%%

d.mean=1261.29; d.sem = 0.002;
printmeanvar_singlesig( d.mean, d.sem )

d.mean=0.0983; d.sem = 0.0058; % should be  0.098+-0.006
printmeanvar_singlesig( d.mean, d.sem )

d.mean=0.00001154; d.sem = 0.002;
printmeanvar_singlesig( d.mean, d.sem )

d.mean=0.00001154; d.sem = 0.0000002;
printmeanvar_singlesig( d.mean, d.sem )


%%

d.mean=135; d.sem = 18; % 140+-20
printmeanvar_singlesig( d.mean, d.sem )
%%
disp('s')
d.mean=0.00001154; d.sem = 0.0000002;
printmeanvar_singlesig( d.mean, d.sem )

%%
[var_digits,var_decimal,varStr] = digitsdecimals( '2e-07' )

%%
d.sem = 2660.012
%d.sem = 0.00151953;



