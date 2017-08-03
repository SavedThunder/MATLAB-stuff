%Lecture 11
%
%Final Practice
%
%Kyle O'Connor

home;
clear all;
clc;

r = roots([2 -121 (60.5^2 - 95^2)]);
xtop = -r(1):1:r(1);
xl = -r(1):.1:0;
xr = 0:.1:r(1);
ytop = sqrt(95^2 - xtop.^2);
ylbase = -xl-60.5;
yrbase = xr-60.5;
plot(xtop,ytop,'g',xl,ylbase,'g',xr,yrbase,'g')
hold on;
xpm = -9:.1:9;
ypmtop = sqrt(9^2 - xpm.^2);
ypmbottom = -sqrt(9^2 - xpm.^2);
plot(xpm,ypmtop,'k',xpm,ypmbottom,'k')
plot([-100 100] , [0,0],'k--')
area1 = sum(MyTrap(ytop,xtop));
area2 = sum(MyTrap(ylbase,xl));
area3 = sum(MyTrap(yrbase,xr));
area_num = area1 - area2 - area3