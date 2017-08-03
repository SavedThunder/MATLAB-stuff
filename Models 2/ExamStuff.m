% To be used for models II exam
%% Problem 1 Numerical Differentiation 
clear; clc; close all;
% Change t to the time vector 
t = 0:0.25:2.25;
pos = [0,1,2.5,3,4.5,3.5,2.5,2,1,0.5];
%for k = 1:length(t)
    % Change pos(k) = to a function of t 
%    pos(k) = t(k) + 10;
%end
figure(1)
plot(t,pos);
title('Plot of function');
for k = 1:length(t)-1
    twoPointForward(k) = (pos(k+1)-pos(k))/(t(k+1)-t(k));
end
figure(2)
plot(t(1:length(t)-1),twoPointForward);
title('Plot of twoPoint Forward');
for k = 2:length(t)
    twoPointReverse(k-1) = (pos(k)-pos(k-1))/(t(k)-t(k-1));
end
figure(3)
plot(t(2:length(t)),twoPointReverse);
title('Plot of twoPoint Reverse');
for k = 2:length(t)-1
    threePoint(k) = (pos(k+1)-pos(k-1))/((t(k+1)-t(k-1)));
end
figure(4)
plot(t(2:length(t)-1),threePoint(2:length(threePoint)));
title('Plot of threePoint');
%% Problem 2 Numerical Integration
clear; clc; close all;
% Change t to the time vector 
t = 0:0.01:10;
for k = 1:length(t)
    % Change pos(k) = to a function of t 
    pos(k) = t(k) + 10;
end
figure(1)
plot(t,pos);
title('Plot of function');
% simpsons rule = simpsons(dependent variable, indepenent variable, lower
% bound, upperbound)
% Example f(x) = 20x + 4
% simpsons(f,x,1,3) will return the simpsons estimation from 1 to 3
area = MySim(pos,t);
fprintf('The estiamtion using Simpsons rule is %0.2f\n',area);
%% Problem 3 min max and concavity 
clear; clc; close all;
% Change t to the time vector 
t = -10:0.01:10;
for k = 1:length(t)
    % Change pos(k) = to a function of t 
    pos(k) = -t(k).^2 + 1;
end
figure(1)
plot(t,pos);
title('Plot of function');
for k = 1:length(t)-1
    twoPointForward(k) = (pos(k+1)-pos(k))/(t(k+1)-t(k));
end
figure(2)
plot(t(1:length(t)-1),twoPointForward);
title('Plot of twoPoint Forward');
for k = 2:length(t)-1
    secondDerivative(k) = (pos(k+1)-2*pos(k)+pos(k-1))/((t(k+1)-t(k))^2);
end
figure(3)
plot(t(2:length(t)-1),secondDerivative(2:length(secondDerivative)));
axis equal
title('Plot of Second Derivative');
%% Problem 4 Find the Area of an object
clear; clc; close all;
% Replace the x = to proper x vector 
x = -6.9282:0.01:6.9282;
% Replace the yTop = to the top Function
yTop = sqrt(169-x.^2);
% Replace the yBottom = to the bottom Function
yBottom = -sqrt(25-x.^2)+16;
plot(x,yTop,'b',x,yBottom,'g',3,12,'*');
% Check to see if area should be subrtracted or added bellow
area = MySim(yBottom,x)-MySim(yTop,x);
fprintf('The area between the curves is %0.2f\n',area);
%% Problem 5 Find the Arc Length of a Path
% This will return the length of a single function to return multiple
% arclengths repeat several times as needed.
clear; clc; close all;
% Replace this with the proper x vector
x = 0:0.01:5;
% Replace this with the function of x
y = (x.^4)-(12*x.^3)+(48.25*x.^2)-(71.25*x)+(25);
plot(x,y);
dy = (4*x.^3)-(36*x.^2)+(96.5*x)-(71.25);
arcLength = MySim(sqrt((dy.^2)+1),x);
%% Problem 6 Find the Centroid of an object
% This will be used to find the centroid between two curves
clear; clc; close all;
% Replace the x = to proper x vector 
x = -3:0.01:8;
% Replace the yTop = to the top Function
yTop = (1/3)*x.^2;
% Replace the yBottom = to the bottom Function
yBottom = (-1/16)*(x-4).^2 -2;
plot(x,yTop,x,yBottom);
% Check to see if area should be subrtracted or added bellow
area1 = MySim(yTop,x);
area2 = MySim(yBottom,x);
area = MySim(yTop,x)-MySim(yBottom,x);
fprintf('The area between the curves is %0.2f\n',area);
xbar = (1/area).*MySim(x.*(yTop-yBottom),x);
ybar = (1/(2*area)).*MySim(yTop.^2-yBottom.^2,x);
fprintf('The x cordinate of the centroid is %0.2f\n',xbar);
fprintf('The y cordinate of the centroid is %0.2f\n',ybar);
%%
home;
clear;
clc;

x = -6.9282:0.1:6.9282;
topcircle = sqrt(169 - x.^2);
plot(x,topcircle)
area1 = MySim(topcircle,x);
bottomcircle = -sqrt(abs(25-x.^2)) + 16;
plot(x,bottomcircle)
area2 = MySim(bottomcircle,x);

%%
home;
clear;
clc;


v = sym('((60/f^5)*t^4) - ((120/f^4)*t^3) + ((60/f^3)*t^2)');
f = 8;
v = subs(v)
solve(v,'t')