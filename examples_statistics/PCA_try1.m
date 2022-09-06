

%% Try PCA
clear all
load hald
[coeff,score,latent] = pca(ingredients);

score*coeff' % these are original x with means subtracted
ingred_means = mean(ingredients);
ingredients - ingred_means  % (X-mean(x))= score*coeff' e.g. to transform x to the PCA's new base, we need to multiply: (X-mean(x))*inv(coeff')

coeffTInv = inv(coeff'); % these are the weights of the original variables to ptroduce the first  principal component

% From mathworks - LDA
% Once you get out your LDA model using the fitcdiscr function, you need to calculate the eigenvalues and eigenvectors, which are obtained by using the eig function on the BetweenSigma and Sigma properties of your LDA model. The Eigenvalues and Eigenvectors are then sorted into descending order, and your resultant output is simply the product of your original Input X and the Eigenvector W. Example code: 
% Mdl = fitcdiscr(X,L)
% [W, LAMBDA] = eig(Mdl.BetweenSigma, Mdl.Sigma) %Must be in the right order! 
% lambda = diag(LAMBDA);
% [lambda, SortOrder] = sort(lambda, 'descend')
% W = W(:, SortOrder);
% Y = X*W;