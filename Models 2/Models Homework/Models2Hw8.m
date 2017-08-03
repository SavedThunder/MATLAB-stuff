%14.5506 ft^2
%55.4167
%
%Kyle O'Connor
%
%4/20/2016
%
%Homework 9
home;
clear;
clc;

%Area
x = 0:0.01:10;
ytop = (1/32)*((x-2).^2) + 12;
ybot = (14/10).*x;
plot(x,ytop,'k',x,ybot,'b');
area1 = sum(MySim(ytop,x));
area2 = sum(MySim(ybot,x));
total = area1 - area2;
ybar = (1/(2*total))*sum(MySim(ytop.^2 - ybot.^2,x));
xbar = (1/total)*sum(MySim(x.*(ytop - ybot),x));
disp(xbar)
disp(ybar)

