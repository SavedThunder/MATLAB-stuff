%Kyle O'Connor
%
%Lab 8 
%
%3/2/2016

home;
clear all;
clc;

load Lab8;

Data.Power = 120*Data.Current;
min = Data.Min;
size = 337678;
sec = Data.Second;
dt = zeros(size,1);
power = Data.Power;
for c = 2:size
    dt(c,1) = ((min(c,1)*60) + sec(c,1)) - ((min(c-1,1)*60) + sec(c-1,1));
end
for c = 1:size
    if dt(c,1) < 0
        dt(c,1) = (60 - Data.Second(c-1)) + Data.Second(c);
    end
end
Data.DeltaT = dt;
total = 0;
for c = 1:size
    total = total + dt(c);
end
AVGdt = (total/size);
maximum = max(dt);

for c = 2:size
      EU(c,1) = (((power(c,1) + power(c-1,1))/2)*dt(c));
end

for c = 2:size
    energy(c,1) = ((power(c,1) + power(c-1,1))/2)*dt(c,1);
end
energy = (energy/1000/3600);
Data.Energy = energy;
totalEnergy = 0;
for c = 1:length(energy)
    totalEnergy = totalEnergy + energy(c);
end
ActualEnergy = 320;
percentError = ((ActualEnergy - totalEnergy)/ActualEnergy)*100;
Sept15 = sum(Data.Energy((find(Data.Month == 9 & Data.Day == 15))));
for i = 0:23
    Sept15Hourly(i+1) = sum(Data.Energy((find(Data.Month == 9 & Data.Day == 15 & Data.Hour==i))));
end
% plot(0:23,Sept15Hourly,'r*')
xlabel('Hour of the Day')
ylabel('kWh')
title('Hourly Usage For Sept 15')
count = 0;
for i = 13:30
    count = count +1;
    Sept15DailyUse(count) = sum(Data.Energy((find(Data.Month == 9 & Data.Day == i))));
end
for i = 1:13
   count = count + 1;
   Sept15DailyUse(count) = sum(Data.Energy((find(Data.Month == 10 & Data.Day == i))));
end
plot(1:31,Sept15DailyUse,'b*')
xlabel('Day (Sept 13th - Oct 13th')
ylabel('Usage (kWh)')
title('Daily Usage from Sept 13th - Oct 13th')
   


% current = [3,3.4,3.6,4,3.6];
% power = [360,408,432,480,432];
% time = [47,53,70,184,324];
% dt = [0,6,17,114,140];
% for c = 1:length(time)
%     power(c) = current(c) * 120;
% end
% EU = [0,0,0,0,0];
%  for c = 2:length(time)
%      EU(c) = (((power(c) + power(c-1))/2)*dt(c));
%  end
%  
%  for c=1:length(time)
%      EUK(c) = ((EU(c)/1000)/3600);
%  end



