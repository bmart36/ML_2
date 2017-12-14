%%% Prediction on diabetes progression from the current status of pacient
%%% evaluated in terms of age, sex, body mass index, average blood
%%% pressure, and six blood serum measurements

%% Loading data
load('diabetes'); % x = matrix of inputs, y = vector of outputs

x(:,2) = double( x(:,2)==1 ); % convert to a 0-1 variable sex
x = x2fx(x, 'linear'); % add column of ones

%% Data set partitions for cross-validation
rng('default');
cv = cvpartition( size(x,1), 'kfold', 10 );

%% Cross-validation on MSE obtained by linear regression
MSE_train = 0;
MSE_valid = 0;
for i = 1 : cv.NumTestSets
    % training data
    idx_train = cv.training(i);
    x_train = x(idx_train,:);
    y_train = y(idx_train,:);
    
    % validation data
    idx_valid = cv.test(i);
    x_valid = x(idx_valid,:);
    y_valid = y(idx_valid,:);
    
    % linear regression
    w = regress(y_train, x_train);
    
    % training MSE
    r = y_train - x_train * w;
    MSE_train = MSE_train + mean(r.^2);
    
    % validation MSE
    r = y_valid - x_valid * w;
    MSE_valid = MSE_valid + mean(r.^2);
end
MSE_train = MSE_train / cv.NumTestSets;
MSE_valid = MSE_valid / cv.NumTestSets;

%% Above loop implemented in function
MSE_regress = crossval(@regress_mse, y, x, 'partition', cv);
MSE_regress = mean(MSE_regress);

%% Cross-validating ridge and lasso
% cross-validation
MSE_regress = crossval(@regress_mse, y, x, 'partition', cv);

% cross-validation with a parameter
lambda = 0 : 0.2 : 1.6;
MSE_ridge=crossval( @(a,b,c,d) ridge_mse(a,b,c,d,lambda),y, x, 'partition', cv );
MSE_lasso=crossval( @(a,b,c,d) lasso_mse(a,b,c,d,lambda),y, x, 'partition', cv );

% average the observations
MSE_regress = mean(MSE_regress);
MSE_ridge = mean(MSE_ridge);
MSE_lasso = mean(MSE_lasso);
figure;
plot(lambda, ones(size(lambda))*MSE_regress, 'k-');
hold on;
plot(lambda, MSE_ridge, 'b-');
plot(lambda, MSE_lasso, 'r-');
legend({'Ordinary' 'Ridge' 'Lasso'});



