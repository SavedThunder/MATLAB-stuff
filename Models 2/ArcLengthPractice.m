%Lecture 4/5/2016
%
%Kyle O'Connor
%
%Arc Length

home;
clear all;
clc;
x = -300:.1:300;
y = (-1/1200)*x.^2;
figure(1)
subplot(2,1,1)
plot(x,y,'k')
axis([-300 300 -300 300])
my_dy = (-1/600)*x;
my_arc = MyTrap(sqrt(1+my_dy.^2),x);
arclength = sum(my_arc);
my_area = arclength * 15;
cost = my_area * 4.5;
%symb
y_sym = sym('(-1/1200)*x^2');
subplot(2,1,2)
ezplot(y_sym,[-300 300])
axis([-300 300 -300 300])
dy_sym = diff(y_sym,'x');
sym_arc_length = int(sqrt(1 + (dy_sym^2)),'x',-300,300);
sy_arc_length = double(sym_arc_length);