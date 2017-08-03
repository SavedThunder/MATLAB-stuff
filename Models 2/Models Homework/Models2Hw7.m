%HW7 answers numerically 42.5983 symb 42.5983
%num 2: 612.5 612.5
%num 3: 9.60 9.60 Units***

home;
clear all;
clc;
x = -5:.1:5;
yb = ((-2.4+0.6)/25)*x.^2;
yt(1:length(x))=.6;
plot(x,yt,x,yb)
integ1 = 10*0.6;
integ2 = sum(MyTrap(yb,x));
area = integ1 - integ2;
area = area*0.8
