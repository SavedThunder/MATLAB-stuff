clear;clc;
time = xlsread('Height.xlsx', 'B1:GJ1');
h = xlsread('Height.xlsx', 'B4:GJ8');
a25 = h(1,:);
a35 = h(2,:);
a45 = h(3,:);
a55 = h(4,:);
a65 = h(5,:);


plot(time, a25,time, a35,time, a45,time, a55,time, a65) 
xlabel('Time (sec)')
ylabel('Height (meters)')
title('Height vs. Time')
legend('25°','35°','45°','55°','65°')


    
    