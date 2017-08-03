%Kyle O'Connor
%
%HW 4
%
%2/27/2016

home;
clear all;
close all;
clc;

% load HW4
% dt = t(2)-t(1);
% for i = 1: length(t)
%     ThJoint(i) = 20 + (0.0061002) *t(i)^5 + (-0.152505)*t(i)^4 + (1.0167) * t(i)^3;
%     ActualJointVel(i) = ((5*(6.1002*(10^-3)))*t(i)^4) - (4*0.152505*t(i)^3) + (3*1.0167*t(i)^2);
%     ActualJointAcc(i) = (20*(6.1002*(10^-3))*t(i)^3) - (12*0.152505*t(i)^2) + (6*1.0167*t(i));
% end
% plot(t,ThJoint)
% hold on;
% plot(t,Th2_n)
% title('Actual vs. Noisy')
% xlabel('Time (sec)')
% ylabel('Joint Angle Position')
% legend('Actual','Noisy')
% for i = 2:length(t)
%     VelJointEst(i) = (Th2_n(i) - Th2_n(i-1))/dt;
% end
% for i = 2:length(t)-1
%     AccJointEst(i) = (Th2_n(i+1) - 2*Th2_n(i) + Th2_n(i-1))/(dt^2);
% end
% figure
% plot(t,VelJointEst)
% hold on;
% plot(t,ActualJointVel)
% xlabel('Time')
% ylabel('Velocity')
% legend('Estimate','Actual')
% title('Actual/Estimate Velocities')
% AccJointEst(30) = 0;
% 
% figure
% plot(t,AccJointEst)
% hold on;
% plot(t,ActualJointAcc)
% xlabel('Time (sec)')
% ylabel('Accleration')
% title('Noisy vs. Actual Acceleration')
% legend('Estimate','Actual')

Lbase = 5;
Ljoint = 4;
time = 0:.75:9.75;
dt = time(2) - time(1);
dt = .75;

%Finding Base and Joint Angles/Velocities
for i = 1:length(time)
    ThBase(i) = 30 + (-9.684*(10^-4))*time(i)^5  +  (0.02421)*time(i)^4 + (-.1614)*time(i)^3;
    ThJoint(i) = 20 + (0.0061002) *time(i)^5 + (-0.152505)*time(i)^4 + (1.0167) * time(i)^3;
    ActualBaseVel(i) = (-5*(9.684*(10^-4))*time(i)^4) + (4*0.02421*time(i)^3) - (3*0.1614*time(i)^2);
    ActualJointVel(i) = ((5*(6.1002*(10^-3)))*time(i)^4) - (4*0.152505*time(i)^3) + (3*1.0167*time(i)^2);
    ActualBaseAcc(i) = (-20*(9.684*(10^-4))*time(i)^3) + (12*0.02421*time(i)^2) - (6*0.1614*time(i));
    ActualJointAcc(i) = (20*(6.1002*(10^-3))*time(i)^3) - (12*0.152505*time(i)^2) + (6*1.0167*time(i));
end
%2 Point Reverse
for i = 2:length(time)
    VelBaseEst(i) = (ThBase(i) - ThBase(i-1))/dt;
    VelJointEst(i) = (ThJoint(i) - ThJoint(i-1))/dt;
end
%Second Derivative
for i = 2:length(time)-1
    AccBaseEst(i) = (ThBase(i+1) - 2*ThBase(i) + ThBase(i -1))/(dt^2);
    AccJointEst(i) = (ThJoint(i+1) - 2*ThJoint(i) + ThJoint(i-1))/(dt^2);
end
%Velocity Plot/Error
figure
plot(time,ActualBaseVel)
hold on;
plot(time,VelBaseEst)
plot(time,ActualJointVel)
plot(time,VelJointEst)
xlabel('Time (sec)')
ylabel('Velocity (deg/sec)')
legend('Actual Base Vel', 'Base Vel Est.','Actual Joint Vel','Joint Vel Est.')
title('Estimated Joint/Base Velocity vs. Actual Velocity')
hold off;
for i = 1:length(time)
    VelBaseError(i) = abs(ActualBaseVel(i) - VelBaseEst(i));
    VelJointError(i) = abs(ActualJointVel(i) - VelJointEst(i));
end
figure
plot(time, VelBaseError)
hold on;
plot(time, VelJointError)
title('Velocity Estimation Error')
legend('Base Error','Joint Error')
xlabel('Time (sec)')
ylabel('Velocity (deg/sec)')
MaxBaseVelError = max(VelBaseError);
MaxJointVelError = max(VelJointError);
%Acc Plotting/Error
figure
plot((1:length(time)-1),AccBaseEst,'r')
hold on;
plot((1:length(time)-1),AccJointEst,'g')
plot((1:length(time)),ActualBaseAcc,'b')
plot((1:length(time)),ActualJointAcc,'k')
title('Accleration Estimate vs Actual')
xlabel('Time (sec)')
ylabel('Accleration (deg/sec^2)')
legend('Base Est','Joint Est','Actual Base','Actual Joint')
AccBaseError(14) = 0;
AccJointError(14) = 0;
for i = 1:length(time)-1
    AccBaseError(i) = abs(ActualBaseAcc(i) - AccBaseEst(i));
    AccJointError(i) = abs(ActualJointAcc(i) - AccJointEst(i));
end
figure
plot(time,AccBaseError)
hold on;
plot(time,AccJointError)
title('Accleration Estimation Error')
xlabel('Time (sec)')
ylabel('Accleration (deg/sec^2)')
legend('Base Error', 'Joint Error')
MaxBaseAcc = max(AccBaseError);
MaxJointAcc = max(AccJointError);

dt = 0.01;
copydt = dt;
MaxJointVelError = 0;
while(MaxJointVelError < 1)
    dt = dt + 0.01;
    time = 0:dt:9.75;
    for i = 1:length(time)
        ThJoint(i) = 20 + (0.0061002) *time(i)^5 + (-0.152505)*time(i)^4 + (1.0167) * time(i)^3;
        ActualJointVel(i) = ((5*(6.1002*(10^-3)))*time(i)^4) - (4*0.152505*time(i)^3) + (3*1.0167*time(i)^2);
    end
    for i = 2:length(time)
        VelJointEst(i) = (ThJoint(i) - ThJoint(i-1))/dt;
    end
    VelJointError = abs(ActualJointVel - VelJointEst);
    MaxJointVelError = max(VelJointError);
end
dt = dt - copydt;
% Finding Coordinates of Base/Joint
% for i = 1:length(time)
%     YBase(i) = 5*sin(ThBase(i));
%     XBase(i) = 5*cos(ThBase(i));
%     XJoint(i) = 4*cos(ThJoint(i));
%     YJoint(i) = 4*sin(ThJoint(i));
% end
% for i = 1:14
%     plot(XBase(1),YBase(i),'ro')
%     hold on;
%     plot(XJoint(i),YJoint(i),'bo')
%     pause();
% end
% Displacement of Gripper from Arm start
% for i = 1:length(time)
%     Finalx(i) = XBase(i) + XJoint(i);
%     Finaly(i) = YBase(i) + YJoint(i);
% end
% 
% 
% calculate error and take off .01 off of the seconds .75