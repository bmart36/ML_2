function w = simple_regression( y,x )
% x = sample inputs
% y = sample outputs
% w = parameters fo the linear prediction f(x) = w1 + w2 * x

mx = mean(x(:));
my = mean(y(:));

w(2) = sum((x(:)-mx) .* (y(:)-my)) / sum((x(:)-mx).^2);
w(1) = my - w(2) * mx;

end

