function MSE = curves_mse(y_train,x_train, y_valid,x_valid)

    for j = 1 : size(y_train,1);
        w = regress( y_train(1:j,:), x_train(1:j,:) );
        
        r = y_train(1:j,:) - x_train(1:j,:) * w;
        MSE(1,j,1) = mean( r.^2 ); % training MSE
        
        r = y_valid - x_valid * w;
        MSE(1,j,2) = mean( r.^2 ); % validation MSE
    end