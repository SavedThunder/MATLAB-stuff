%Kyle O'Connor
%
%4/12/2016
%
%

home;
clear all;
clc;

x_num = 0:.01:1.2;
yt_num = sqrt(4-((4*x_num.^2)/1.44));
yb_num = -sqrt(1.44-x_num.^2);
plot(x_num,yt_num,x_num,yb_num)
hold on;
plot([0 0],[-1.2 2])
axis equal
areat = sum(MyTrap(yt_num,x_num));
areab = sum(MyTrap(yb_num,x_num));
areatotal = abs(areat) + abs(areab);
x_bar = (1/(areatotal))*sum(MyTrap(x_num.*(yt_num-yb_num),x_num))
y_bar = (1/(2*areatotal))*sum(MyTrap((yt_num.^2-yb_num.^2),x_num))
hold on;
plot(x_bar,y_bar,'r*')
-sqrt(1.44-x_num.^2)