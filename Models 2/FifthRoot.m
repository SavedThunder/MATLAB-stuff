function [ ans ] = FifthRoot( num,guess )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%Kyle O'Connor
%
%Lab 7
%
%2/24/2016
%


count = 0;
% if guess == 0;
%    guess = guess + 0.01;
% end
func =  guess^5 - num;
deriv = 5*guess^4;
while((abs(func) > 0.0001) && (count < 100))
    guess = guess - (func/deriv);
    func = guess^5-num;
    deriv = 5*guess^4;
    count = count + 1;
    approx(count) = func;
    if deriv == 0
        guess = guess + 0.01;
    else
        deriv = 5*guess^4;
    end
    
end

fprintf('Iterations: %i\n', count);
if count < 100
    fprintf('Estimate: %i\n', guess)
else
    fprintf('Could not converge with current guess')
end
ans = guess;
%plot(1:count,approx,'ro')


end

