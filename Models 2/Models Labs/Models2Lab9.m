%Kyle O'Connor
%
%Lab 9
%
%3/9/2016

home;
clear all;
clc;

load Airplane_Hatch
%load Submarine_Hatch
%Submarine Hatch Plot
plot(x_left,y_hatch)
hold on;
plot(x_right,y_hatch)
axis([-2 2 0 4])
xlabel('X axis')
ylabel('Y axis')
title('Submarine Hatch')

altitude = input('What altitude is the plane at? ');
%saltDens = 1027;
ap = 101353;
g = 9.8;
totalForce = 0;
dy = abs(y_hatch(2) - y_hatch(1));

%Outisde Pressure and Force update
for i = 1:length(y_hatch)-1
    h = altitude - y_hatch(i);
    area = ((x_right(i) - x_left(i)) + (x_right(i+1) - x_left(i+1)))/2;
    pressure(i) = ap * ((1 - ((2.25577*10^-5) * h)))^5.25588;
    
end

%summed Outside
totalOutForce = (sum(pressure) * area);
%inside Force updated
for i = 1:length(y_hatch)-1
    area = ((x_right(i) - x_left(i)) + (x_right(i+1) - x_left(i+1)))/2;
    insideForce(i) = ap * area * dy;
end
%Summed Inside
totalInside = sum(insideForce);
TotalForce = totalOutForce - totalInside;
fprintf('Altitude: %i\n', altitude)
fprintf('Pressure: %i\n', sum(pressure))
fprintf('Total Outside Force: %13.0f \n', totalOutForce)
fprintf('Total Inside Force: %7.0f \n', totalInside)
fprintf('Total Force on Hatch: %13.0f\n', TotalForce)
if TotalForce < 350000
    fprintf('The Altitude IS safe')
else
    fprintf('The Altitude IS NOT safe')
end