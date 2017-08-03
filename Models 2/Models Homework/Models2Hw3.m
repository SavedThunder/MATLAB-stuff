%Kyle O'Connor
%
%HW 3
%
home;
clear all;
clc;

% load HW3P4
% 
% 
% title('Position over Time')
% xlabel('Time (sec)')
% ylabel('Position (mm)')
% delt = 0.1;
% for i = 2:length(t)
%     f(i) = (pos(i) - pos(i-1))/(delt)
% end
% plot(t,f,'r*',t_act,v_act,'bo');
% xlabel('Time (sec)')
% ylabel('Velocity (m/s)')
% title('Velocity over Time')
% legend('Estimate','Actual')
load HW3P2
plot(t,V,'ro')
xlabel('Time(sec)')
ylabel('Volts')
title('Volts over Time')
% 
% 
% g = 0:0.005:.8;
% nearest = interp1(t,V,g,'nearest');
% linear = interp1(t,V,g,'linear');
% spline = interp1(t,V,g,'spline');
% 
% plot(t,V,'r*')
% hold on;
% plot(g,spline,'bo')
% title('Voltage Over Time')
% xlabel('Time (sec)')
% ylabel('Voltage (volts)')
% legend('Actual Data','Spline Estimate')
% subplot(3,1,2)
% plot(t,V,'r*')
% plot(g,linear,'bo')
% subplot(3,1,3)
% plot(t,V,'r*')
% plot(g,spline,'bo')