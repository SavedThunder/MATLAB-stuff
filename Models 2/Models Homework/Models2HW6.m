%Homework 6
%
%Kyle O'Connor
%
%3/16/2016

home;
clear all;
clc;

load HW6

level(1) = 9;
volume(1) = (pi*4*level(1));
dt = input('What is the change in time? ');
D = 0.1;
g = 32.2;
OutRate(1) = pi*(D/2)^2*(sqrt(2*32.2*(level(1)-(D/2))));
count = 1;
time(1) = 0;
while(level(count)>0.1)
    count = count+1;
    OutRate(count) = pi*((D/2)^2)*(sqrt(2*32.2*(level(count-1)-(D/2))));
    volume(count) = volume(count-1) - (OutRate(count)*dt);
    level(count) = volume(count)/(pi*4);
    time(count) = time(count-1)+dt;
end
totalTime = dt*count;

plot(time,level,'blo')
xlabel('Time Elapsed')
ylabel('Water Level (ft)')
title('Water Level Over Time')
fprintf('Level: %0.3f\n',level(length(level)))
fprintf('Total Time: %0.3f\n',time(length(time)))
% time = 0:30:180;
% flow_rate = [0 .5 .7 .3 .5 .5 .3];
% dt = time(2) - time(1);
% 
% TrapInteg = MyTrap(flow_rate,time,0,120);
% OneA = sum(TrapInteg)+400
% SimpsonsOne = 0;
% SimpsonsOne = (dt/3)*(flow_rate(1)+4*flow_rate(2)+2*flow_rate(3)+4*flow_rate(4)+flow_rate(5))+400
