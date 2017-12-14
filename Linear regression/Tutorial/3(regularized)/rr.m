% define a polynomial
P = @(t)[ones(size(t,1),1) t.^2 t.^3 t.^4 t.^5 t.^6 t.^7 t.^8 t.^9];

% generate data
t = (-1 : 0.2 : 1)';
x = P(t);
y = randn(length(t), 1);

% standard regression
w1 = regress(y, x);

% ridge regression (RECALL: no column of ones in x !!!)
lambda = 0.05;
w2 = ridge (y, x(:,2:end), lambda, 0);

% lasso regression (RECALL: no column of ones in x !!!)
[w3, infos] = lasso(x(:, 2:end), y, 'Lambda', lambda);
w3 = [infos.Intercept; w3];

% visualization
s = (-1 : 0.0001 : 1)';
plot(t,y,'ok',s,P(s)*w1,'b',s,P(s)*w2,'r',s,P(s)*w3,'g');
legend({'Samples' 'Standard' 'Ridge' 'Lasso'})

fprintf('Ridge: %d/%d\n', sum(w2~=0), length(w2));
fprintf('Lasso: %d/%d\n', sum(w3~=0), length(w3));

[w,infos] = lasso(x(:,2:end),y, 'Lambda', 0:0.01:1 );
lassoPlot(w, infos, 'PlotType', 'Lambda','XScale','log');