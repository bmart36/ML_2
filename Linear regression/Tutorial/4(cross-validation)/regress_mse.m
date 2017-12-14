function MSE = regress_mse(y_train,x_train, y_valid,x_valid)

% linear regression
w = regress(y_train, x_train);

% validation MSE
r = y_valid - x_valid * w;
MSE = mean( r.^2 );


