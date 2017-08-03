% Kyle O'Connor
%
% January 13, 2016
%
% Lab 1
% inputs
clear
close all
home
units = menu('What is the SI unit?', 'SI on Earth', 'Gravitaional on Earth','SI on the Moon');
answer = 'no';
while strcmpi(answer,'no')
    %Graviational Pull
    if units == 1
        g = 9.81;
    elseif units == 2
        g = 32.2;
    else
        g = 6.25; 
    end
%Units Used For Velocity
    if units == 2
        x0=input('What is the x0 value in feet? ');
        y0=input('What is the y0 value in feet? ');
        ti=input('What is the time value in seconds? ');
        v0=input('What is the velocity value in feet/sec? ');
    else
        x0=input('What is the x0 value in meters? ');
        y0=input('What is the y0 value in meters? ');
        ti=input('What is the time value in seconds? ');
        v0=input('What is the velocity value in meters/sec? ');
    end
    answer = input('Is this data correct? yes/no [Yes]','s');
    
    if isempty(answer)|| strcmpi(answer,'y')|| strcmpi(answer,'ye')|| strcmpi(answer,'yes')
    else
        strcmpi(answer,'no')
    end
end
       

%Original Individual Case Inputs
%x0=input('What is the x0 value in meters? ');
%y0=input('What is the y0 value in meters? ');
%ti=input('What is the time value in seconds? ');
thd=input('What is the angle of attack for the projectile? ');
%v0=input('What is the velocity value in meters/sec? ');
%g=input('What is the gravitational value? (Earth = 9.81) ');
% engineering work
% convert to radians
thr=thd*pi/180;
% find time for projectile to hit ground
hit=roots([-.5*g v0*sin(thr) y0]);
thit=max(abs(hit));
% set time vector
t=0:ti:thit+ti;
% compute motion
y=-.5*g*t.^2+v0*sin(thr)*t+y0;
x=v0*cos(thr)*t+x0;

% subplots
figure (1)
subplot(2,1,1)
plot(t,y,'k',t,x,'r')
xlabel('time (sec)')
if units == 2
    ylabel('height and distance (feet)')
else
    ylabel('height and distance (meters)')
end
title('height and distance verses time')
legend('height','distance','location','best')
axis([0 thit 0 max(x)])
subplot(2,1,2)
plot(x,y,'m')
if units == 2
    xlabel('distance (feet)')
    ylabel('height (feet)')
else
    xlabel('distance (meters)')
    ylabel('height (meters)')
end
title('distacne versus height')
axis([0 max(x) 0 max(x)])
% formatted output

if units == 2
    fprintf('The Velocity of the projectile is: %0.3f feet ' , 'v0')
    fprintf('The time it took the projectile to hit is %0.3f seconds at %i°','thit','thd')
    fprintf('The Maximum height was: %0.3f feet','y')
    fprintf('The Total Horizontal Distance was: %0.3f feet','x')
else
    fprintf('The Velocity of the projectile is: %0.3f meters ' , 'v0')
    fprintf('The time it took the projectile to hit is %0.3f seconds at %i°','thit','thd')
    fprintf('The Maximum height was: %0.3f meters','y')
    fprintf('The Total Horizontal Distance was: %0.3f meters','x')
end
    
