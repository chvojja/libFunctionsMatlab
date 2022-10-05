function y  = temptest(T)
%TEMPTEST Temp testing function

y = [];

% profiler on
% now launch some function
% profreport('example1')

% prepare
Nf = 1000;
sel_rows = randsample(1:size(T,1),Nf);
for i = sel_rows
   % T.fun(i)={ @()readvar( Files = char(T.Signal(i)) , ReadFun = @(x)loadbin(x, [1,5000] , 'double' ), CatDim = 1 ) };
  % expr = [ ' T.fun(i) = { @()readvar( Files = '  char(T.Signal(i))   ', ReadFun = @(x)loadbin(x, [1,5000] , ''double'' ), CatDim = 1 ) }; ' ];
   % T.fun(i) = eval(  char( sprintf(" T.fun(i) = { @()readvar( Files = '%s', ReadFun = @(x)loadbin(x, [1,5000] , 'double' ), CatDim = 1 ) }; ",char(T.Signal(i))) )  );
  % [y1,y2] = splitpath( FilePath = char(T.Signal(i)) , SplitByLastFew = 3);
   %T.fun(i) = eval(  char( sprintf(" { @(x)loadbin( fullfile(x, '%s' ), [1,5000] , 'double' ) }; ",    y2  ) )  );
   T.fun(i) = eval(  char( sprintf(" { @()loadbin( '%s' , [1,5000] , 'double' ) }; ",   char(T.Signal(i))  ) )  );

end

% test
files = T.Signal( sel_rows);
filehandles = T.fun( sel_rows );

% old way
tic
 y = readvar( Files = files , ReadFun = @(x)loadbin(x, [1,5000] , 'double' ), CatDim = 1 );
toc

% new way
%arg = y1;
tic
y = fevalc( filehandles  );
toc


