%Kyle O'Connor
%
%2/17/2016
%
%Lab 6

home;
clear all;
clc;

ans = menu('Which data set? ','Set 1','Set 2')
if ans == 1
    load GPS_Data1
else
    load GPS_Data2
end

figure(1);
dt = diff(time);
dt = seconds(dt);
 
 for c = 2:length(time)
     dist(c)=222240*(asind(sqrt((sind((latitude(c)-latitude(c-1))/2))^2 +cosd(latitude(c-1))*cosd(latitude(c))*(sind((longitude(c)-longitude(c-1))/2))^2)));
%      disSin1 = sin(lat(t(i)) - (lat(t(i)+1)-lat(t(i)))/2)^1/2;
%      disCos1 = cos(lat(t(i)+1)-lat(t(i)));
%      disCos2 = cos(lat(t(i)));
%      disSin2 = sin(long(t(i)) - long(t(i)+1)-long(t(i))/2);
 end
 position = [0 0 0 0 0 0];
for j = 2:length(time)
    position(j) = position(j-1) + dist(j);
end
for g = 2:length(time)-1
    acc(g) = ((position(g+1)-2*position(g)) + position(g-1))/(dt(g))^2;
end

for o = 2:length(time)
    vel2(o) = (position(o) - position(o-1))/dt(o-1);
    
end
for w = 2:length(time)- 1
    vel3(w) = (position(w+1) - position(w-1))/(2*dt(w));
end
subplot(2,1,1)
plot(time,vel2)
hold on;
plot(time,actual_velocity,'r*')
title('Calculated Data vs. Time')
xlabel('Time (sec)')
ylabel('Velocity (m/s)')
plot(time(1:length(time)-1),vel3,'bo')
legend('Actual','2pt Estimate','3pt Estimate')

for u = 2:length(time);
error2(u) = abs(actual_velocity(u) - vel2(u))/actual_velocity(u);
end

for u = 2:length(time)-1;
    error3(u) = abs(actual_velocity(u) - vel3(u))/actual_velocity(u);
end
subplot(2,1,2)
plot(time,error2,'r*')
hold on
title('Error')
xlabel('time')
ylabel('m/s')
plot(time(1:length(time)-1),error3,'bo')

for u = 2:length(time)-1;
    errorAcc(u) = abs((actual_acceleration(u) - acc(u))/actual_acceleration(u));
end

figure(2);
subplot(2,1,1)
plot(time(1:length(time)-1), actual_acceleration)
xlabel('Time (sec)')
ylabel('Acceleration')
title('Acceleration Over Time')
hold on;
plot(time(1:length(time)-1),acc,'r*')
subplot(2,1,2)
plot(time(1:length(time)-1),errorAcc,'r*')
title('Acc Error')
xlabel('Time (sec)')
ylabel('Acceleration')


