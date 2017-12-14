load('carbig');

% handle the categorical variables
Cylinders = ordinal(Cylinders);
Model_Year = ordinal(Model_Year);
Origin = nominal(Origin);

% visualize data
figure;
plotmatrix( [Weight Horsepower double(Cylinders) double(Model_Year) double(Origin)], MPG);

% output
y = MPG;

% inputs
x1 = ones(size(MPG));
x2 = [Weight, Weight.^2];
x3 = [Horsepower, Horsepower.^2];
x4 = dummyvar(Cylinders);
x5 = dummyvar(Model_Year);
x6 = dummyvar(Origin);

x = [x1, x2, x3, x4, x5, x6];
w = regress(y, x);

wasnan = isnan(y) | any(isnan(x),2);
y(wasnan) = [];
x(wasnan,:) = [];

z = x * w; % predictions
r = y - z; % residuals

% statistics
MSE = mean( r.^2 );
R2 = 1 - MSE / mean( (y-mean(y)).^2 );
text = sprintf('R^2 = %2.3f -- MSE = %2.3f', R2, MSE);

% residual plot
plot(z, r, 'x', [min(z) max(z)], [0 0], 'r-');
title(text);