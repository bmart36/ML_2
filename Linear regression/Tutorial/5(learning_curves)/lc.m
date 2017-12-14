%%% Prediction on diabetes progression from the current status of pacient
%%% evaluated in terms of age, sex, body mass index, average blood
%%% pressure, and six blood serum measurements

%% Loading data
load('diabetes.mat'); % x = matrix of inputs, y = vector of outputs

x(:,2) = double( x(:,2)==1 ); % convert to a 0-1 variable sex
x = x2fx(x, 'linear'); % add column of ones

%% Data set partitions for cross-validation
rng('default');
cv = cvpartition( size(x,1), 'kfold', 10 );

%% Cross-validation usign learning curves
MSE = crossval(@curves_mse, y, x, 'partition', cv);
MSE = mean(MSE);
MSE = reshape(MSE, [length(MSE)/2 2]);