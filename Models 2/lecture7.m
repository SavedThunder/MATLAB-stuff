%Kyle O'Connor
%
%Lecture 7
%
%2/23/2016
home;
clear all;
clc;

load subwaycar
subplot(3,1,1)
plot(t,x,'r*')
hold on
xlabel('Time')
ylabel('Position')
title('Position/Time')
linear = polyfit(t,x,1);
quadratic = polyfit(t,x,2);
cubic = polyfit(t,x,3);
xfit = polyval(cubic,t);
plot(t,xfit);
hold off;
vel = cubic(1)*3*t.^2 + cubic(2)*2*t + cubic(3);
acc = 6*cubic(1)*t + 2*cubic(2);
for i = 2:length(t)
    NumDivVel(i) = (x(i) - x(i-1))/(2);
end
for i = 2:length(t)
    NumDivAcc(i) = (vel(i) - vel(i-1))/(2);
end
subplot(3,1,2)
plot(t,NumDivVel)
xlabel('Time')
ylabel('Velocity')
title('Velocity/Time')
subplot(3,1,3)
plot(t,NumDivAcc)
xlabel('Time')
ylabel('Acceleration')
title('Acceleration/Time')