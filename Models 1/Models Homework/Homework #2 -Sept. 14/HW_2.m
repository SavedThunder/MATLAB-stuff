clear;clc;clf
heightm = xlsread('ProjectileData.xlsx', 'C2:C22');
rangem = xlsread('ProjectileData.xlsx', 'B2:B22');
timesec = xlsread('ProjectileData.xlsx', 'A2:A22');
poly1 = polyfit(timesec,heightm, 2);
yfit1 = polyval(poly1, timesec);
plot(timesec, heightm, 'b');hold on
plot(timesec,yfit1,'r--');
xlabel('Time (seconds)');
ylabel('Height (meters)');
title('Projectile Motion');
legend('Time v Height','Best Fit');

coeff = -4.8842;
g = 9.81;
%theoretical = -0.5*(g);
theoretical = -4.9050;
Error = abs((4.8842 - 4.9050)./ 4.9050)*100





