clear all

%% Toy example
l = load('carbig'); 
T = struct2table(l);
clear l;

T = categorify(T); 
% Lets say the goal is to predict if the car is old or new based on some features.
T( T.when=='Mid' ,:) =[]; % By deleting 'Mid' category, we created a binary response variable. yes/no = Early / Late
T(:, {'Model_Year', 'Model','org','cyl4'} )=[];  % We dont wont these
T = movevars(T,'when','After','Mfg'); % We need the response variable to the end, otherwise the fscmrmr function will return indexes that
% may incorrectly point to the target response variable instead of to the predictors. Second option is just to split the table into 
% predictors table and single column of response variable.
T = rmmissing( T ) ;
sT = summary(T);

%%
% Determine the relevant variables  (predictors)
[idx,scores] = fscmrmr(T,'when');  % For mix of categorical and continous predictor variables, use fscmrmr, otherwise use fscnca
bar(scores(idx));
xticklabels( T.Properties.VariableNames(idx)' )
%%
% If T was continous variables only
% T.Properties.VariableNames(1:end-1)
% X = table2array(decategorify( T(:,1:end-1) )); % this is just dirty hack how to force use catogorical columns but its not right
% y = table2array(decategorify(  T(:,end) ));
% mdl = fscnca(X,y,'Solver','sgd','Verbose',1);
% figure()
% plot(mdl.FeatureWeights,'ro')
% grid on
% xlabel('Feature index')
% ylabel('Feature weight')

%% Make it imbalanced


lateI = find( T.when == 'Late' );
toDeleteI = randpickpercent(lateI,90);
T(toDeleteI,:) = [];


%% Account for imbalance - set Cost or Priors!

% https://medium.com/urbint-engineering/using-smoteboost-and-rusboost-to-deal-with-class-imbalance-c18f8bf5b805
% lending-club-loan-data
responseColumnName = 'when';

n = size(T,1);
part = cvpartition(n,'Holdout',0.5);
istrain = training(part); % Data for fitting
istest = test(part); 

Ttrain =  T(istrain,:);
Ttest =  T(istest,:);

Mdl = fitcsvm(Ttrain,responseColumnName);
trainError = resubLoss(Mdl)
% trainAccuracy = 1-trainError


cvMdl = crossval(Mdl); % Performs stratified 10-fold cross-validation
cvtrainError = kfoldLoss(cvMdl)

testError = loss(Mdl,Ttest,responseColumnName)


%%
 fitcsvm(X,Y,'KFold',10,'Cost',[0 2;1 0],'ScoreTransform','sign')   % cost gives more penalty for wrong classification class 1 into 2


