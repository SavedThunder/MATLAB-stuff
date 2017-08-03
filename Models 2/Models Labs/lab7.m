%Kyle O'Connor
%
%Lab 7
%
%2/24/2016
%

home;
clear all;
clc;

x = 2;
func = (1000 + (2*x) + 3*(x^(2/3))-(4*x));
deriv = (2*(x^(-1/3))-2);
x = x - (func/deriv);
counter = 1;

while(abs(func) > 0.0001 && counter < 100)
    
    counter = counter+1;
    x = x - (func/deriv);
    func = (1000 + (2*x) + 3*(x^(2/3))-(4*x));
    deriv = (2*(x^(-1/3))-2);
end


cost = (1000 + (2*x) + 3*(x^(2/3)));
sales = 4*x;
profit = cost - sales;
fprintf('Answer check sales - cost = %0.2f', profit)

