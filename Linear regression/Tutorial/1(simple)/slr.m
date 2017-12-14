x=[32 31 30 29 29 28 25 23 20 18 17 17 16 16 15 13 11 11]';
y=[22.7 22.7 22.6 22.6 21.9 21.9 21.8 21.0 20.4 18.6 19.2 18.9 18.5 18.1 17.7 17.2 16.5 15.5]';

w = simple_regression(y,x);
z_lin = w(1) + w(2) * x;

figure;
subplot(2,2,1);
plot(x, y, 'o', x, z_lin, 'r-');
title('Linear prediction');

subplot(2,2,2);
plot(z_lin,y-z_lin,'x', [min(z_lin) max(z_lin)],[0 0],'r-');
title('Residual plot');

% logarithmic prediction
w = simple_regression( y,log(x) );
z_log = w(1) + w(2) * log(x);

% visualization
subplot(2,2,3);
plot(x, y, 'o', x, z_log, 'r-');
title('Logarithmic prediction');

subplot(2,2,4);
plot(z_log,y-z_log,'x', [min(z_log) max(z_log)],[0 0],'r-');
title('Residual plot');