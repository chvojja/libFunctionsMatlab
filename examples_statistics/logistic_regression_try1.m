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
smr = summary(T);
Mdl = fitcsvm(T,'when','KFold',5,'Cost',[0 2;1 0]);   % cost gives more penalty for wrong classification class 1 into 2

Mdl = fitcsvm(T,'when','KFold',5,'Cost',[0 11;1240 0],'Standardize',true); classLoss = kfoldLoss(Mdl), [prediction,score] = kfoldPredict(Mdl); confusionmat( Mdl.Y, prediction)
[Xsvm,Ysvm,Tsvm,AUC] = perfcurve(double(Mdlf.Y),double(    score(:,2)  ),1);  AUC




Mdlf = fitcsvm(T,'when','Cost',[0 11;1240 0],'Standardize',true);
Mdlf = fitPosterior(Mdlf);
[~,score_svm] = resubPredict(Mdlf); % Classify training data (Mdl.X) using trained classifier 
[Xsvm,Ysvm,Tsvm,AUCsvm] = perfcurve(double(Mdlf.Y),score_svm(:,Mdlf.ClassNames),'true');

%% In for loop

k=5;
cp = classperf(lables); 
cvFolds = crossvalind('Kfold', lables, k);   
 for i = 1:k                                 
  testIdx = (cvFolds == i);                %# get indices of test instances
  trainIdx = ~testIdx;                     %# get indices training instances


  svmModel = fitcsvm(data_features(trainIdx,:), lables(trainIdx), 'Standardize',true); % 'KernelFunction','RBF','KernelScale','auto'

  [label,score] = predict(svmModel, data_features(testIdx,:));
  cp = classperf(cp, pred, testIdx);
  cumulative_score= [cumulative_score; score];
  label1 = [label1; label];

end
acc= cp.CorrectRate;
conf= cp.CountingMatrix;

[X,Y] = perfcurve(labels,scores,posclass)

%%
Tf = readtable('C:\Users\Emsušenka\Downloads\customers_v3.xlsx');
Tf = categorify(Tf);
% Tf=T;
%%
T = Tf;

%T(:, {'CONT_ID', 'CONT_CUSTA_ID','CONT_CUST_ID','CCPJ_CP_ID','POST_NAME','DISTRICT_NAME'} ) = [];  % We dont wont these
%T = T(:, {'POCET_UPOMINEK_LAST_12_4UPO', 'PARTNER_ISCORPORATION' , 'y' });
% T = T(:, {'ZPUSOB_ZALOH', 'PARTNER_ISCORPORATION' , 'CP_OKRES','y' });
% T = T(:, {'ZPUSOB_ZALOH' , 'CP_OKRES','y' });
%T = T(:, {'CITY_NAME','ZPUSOB_ZALOH','y' });
%T = T(:, {'CONT_CUSTA_ID','y' });

%T(:, {'POCET_UPOMINEK_LAST_12_4UPO'} ) = []; 
% T = T(:, {'POST_POSTCODE','ZPUSOB_ZALOH','CONT_CUSTA_ID','y' });
% T = T(:, {'CONT_CUSTA_ID','y' });
%T = T(:, {'POCET_UPOMINEK_LAST_12_3UPO','POST_POSTCODE','ZPUSOB_ZALOH','y' });
%T = T(:, {'POCET_UPOMINEK_LAST_12_4UPO', 'y' });
%T = T(:, {'CITY_NAME','ZPUSOB_ZALOH','CONT_CUSTA_ID','y' });
%T = T(:, {'CITY_NAME','CONT_CUSTA_ID','y' });
%T = T(:, {'CITY_NAME','ZPUSOB_ZALOH','y' });
T = T(:, {'POCET_UPOMINEK_LAST_12_3UPO','CITY_NAME','ZPUSOB_ZALOH','y' });
T = rmmissing( T ) ;

[idx,scores] = fscmrmr(T,'y');  % For mix of categorical and continous predictor variables, use fscmrmr, otherwise use fscnca
%bar(scores(idx));
%xticklabels( T.Properties.VariableNames(idx)' )


responseCounts = histcounts(T.y);

% Undersample the negative class
negativeInds = find( T.y ~=1 );
k = round( 0.95*responseCounts(1) );
negativeInds_1 = randsample(negativeInds,k);
negativeInds_2 = setdiff(negativeInds,negativeInds_1);

% % Undersample only a little from positive group
% negativeInds = find( T.y ==1 );
% k = round( 0.9*responseCounts(1) );
% population = negativeInds;
% subsetOFPositiveInds = randsample(population,k);
% 
% Tvalidation = T([ subsetOFNegativeInds subsetOFPositiveInds] ,  : );

T( negativeInds_1 ,:) = [];


responseCounts = histcounts(T.y);

% % Train
% Mdl = fitcsvm(T,'y','KFold',5,'Cost',[0 1; 1 0],'Standardize',true); classLoss = kfoldLoss(Mdl), [prediction,score] = kfoldPredict(Mdl); confusionmat( Mdl.Y, prediction)
% [Xsvm,Ysvm,Tsvm,AUC] = perfcurve(double(Mdl.Y),double(    score(:,2)  ),1);  AUC
% Mdl1=Mdl;

Mdl = fitcsvm(T,'y','KFold',5,'Cost',[0 responseCounts(2); 1*responseCounts(1) 0],'Standardize',true); classLoss = kfoldLoss(Mdl), [prediction,score] = kfoldPredict(Mdl); confusionmat( Mdl.Y, prediction)
[Xsvm,Ysvm,Tsvm,AUC] = perfcurve(double(Mdl.Y),double(    score(:,2)  ),1);  AUC
Mdl2=Mdl;

%
%   'CITY_NAME','ZPUSOB_ZALOH' 0.76
% 'CITY_NAME'  0.7221
% 'CONT_CUSTA_ID' 0.63
% 'ZPUSOB_ZALOH' 0.65
% {'CITY_NAME','ZPUSOB_ZALOH','CONT_CUSTA_ID',  0.7844




%% Try logistic regression

% b = glmfit(X,y,'binomial','link','logit')

mdl = fitglm(T,'Distribution','binomial','Link','logit');
scores = mdl.Fitted.Probability;
[X,Y,T,AUC] = perfcurve(species(51:end,:),scores,'virginica');
plot(X,Y)
rocObj = rocmetrics(species(51:end,:),scores,'virginica');
plot(rocObj)

