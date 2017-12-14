function MSE = ridge_mse(y_train,x_train,y_valid,x_valid, L)

    for i = 1 : length(L)
        w = ridge( y_train, x_train(:,2:end), L(i), 0 );
        
        r = y_valid - x_valid * w;
        MSE(i) = mean( r.^2 ); % validation MSE
    end
