%Kyle O'Connor
%
%HW 5
%
%3/5/2016

home;
clear all;
close all;
clc;

% % L = input('What is the loan amount? ');
% % P = input('What is the monthly payment? ');
% % N = input('How many paymnets are there? ');
% % r = 0.01;
% % Equ = sym('(L*r) - P*(1 - (1/((1+r)^N)))');
% % Equ = subs(Equ);
% % 
% % while(abs(double(Equ)) > 0.0001)
% %     Equ = sym('(L*r) - P*(1 - (1/((1+r)^N)))');
% %     EquP = diff(Equ,'r')
% %     Equ = subs(Equ);
% %     EquP = subs(EquP);
% %     Equ = double(Equ);
% %     EquP = double(EquP);
% %     r = r - (Equ/EquP);
% %     Equ = subs(Equ);
% %     EquP = subs(EquP);
% % end


w = 15000;
E = 5*10^10;
i = 0.25;
L = 40;
s = sym('(w/(48*E*i*L)) * x^2 *(L - x)*(3*L )- 2*x');
s = subs(s);
sp1 = diff(s,'x');
sp2 = diff(sp1,'x');
crits = solve(sp1 == 0,'x');
crits = double(crits);
u = 0:40;
for x = 0:40
    f(x+1) = (w/(48*E*i*L)) * x^2 *(L - x)*(3*L-2*x)
end
plot(u, f)
title('Deflection over Board')
xlabel('Distance')
ylabel('Deflection')


% w = 15000;
% z = 0.5;
% l = 40;
% s = sym('(w/(2*z*l)) * (l-x) * (0.25*l-x)');
% s = diff(s,'x')
% x = 1:40;
% final = solve(s,'x')
% s = subs(s)
% y = (w/(2*z*l)).*(l-x).*(0.25*l-x);
% plot(x,y,'*');
% title('Stress over Board')
% xlabel('Distance')
% ylabel('Stress')

% omega = 150;
% r = 0.03;
% L = 0.500;
% omega_r = 150*(2*pi)*(1/60);
%
% vel = sym('-r*omega_r*sin(Theta) - ((r^2*omega_r*sin(2*Theta))/(2*L))');
% vel = subs(vel);
% subplot(2,1,1)
% %plot([sp(2) cp(2)),[-.55 , .55],'r',cp[(4) cp(4)],[-.55 .55]
% ezplot(vel)
% accel = diff(vel,'Theta');
% cp = solve(accel==0,'Theta');
% cp = double(cp);
% cp_deg = cp*(180/pi);
% jerk = diff(accel,'Theta');
% maxmin = subs(jerk,'Theta',cp);
% maxmin = double(maxmin);
% vel_max = double(subs(vel,'Theta',cp(2)));
% vel_min = double(subs(vel,'Theta',cp(4)));
% subplot(2,1,2)
% ezplot(accel)



