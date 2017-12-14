function MSE = lasso_mse(y_train,x_train,y_valid,x_valid, L)

    for i = 1 : length(L)
        [w,c] = lasso(x_train(:,2:end),y_train,'Lambda',L(i));
        w = [c.Intercept; w];
        
        r = y_valid - x_valid * w;
        MSE(i) = mean( r.^2 ); % validation MSE
    end
