%   Robert W. Rost
%   September 20, 2015
%   Rocket Flight
%   Program will ask user for system of units
%   Based on response, user is asked for
%   empty mass of rocket (kg or slugs)
%   fuelmass (kg or slugs)
%   rate at which rocket burns fuel (kg/sec or slugs/sec)
%   exit velocity of thrust (m/sec or ft/sec)
%   desired height of rocket
%   mass of fuel to add if rocket does not meet desired height
%
clear
close all
home
% Initialize variables
time=zeros(1);                          % time vector
vel=zeros(1);                            % velocity of rocket
height=zeros(1);                       % height of rocket
fuelmass=zeros(1);                   % mass of fuel
maxheighttime=zeros(1);          % time of maximum height of rocket
maxveltime=zeros(1);               % time of maximum velocity of rocket
tpeak=zeros(1);                        % time to peak height
hpeak=zeros(1);                       % height at peak time
thit=zeros(1);                           % time to hit gound
maxheight=zeros(1);                 % maximum height of rocket
maxvel=zeros(1);                      % maximum velocity of rocket
% additional variables:
% emptymass - mass of rocket without fule
% q - rate at which rocket burns fuel
% u - velocity of rocket thrust
% m0- total mass of rocket (emptymass+fuelmass)
% burntime - total time rocket burns fuel (fuelmass/q)
% maximumheight - maximum height rocket must attain
% addfuel - mass of fuel added each itteration
answer='no';
%
% input section
%
unittype=menu('unit type:','SI (g=9.81 ft/sec^2)','gravitational(g=32.2 ft/sec^2)');
if unittype==1
    g=9.81;
else
    g=32.2;
end
name='Weather Sat';
if unittype==1
    emptymass=1460;
    fuelmass(1)=1460;
    q=14.6;
    u=2440;
    maximumheight=57700;
    addfuel=200;
else
    emptymass=100;
    fuelmass(1)=100;
    q=1;
    u=8000;
    maximumheight=200000;
    addfuel=20;
end
check=menu('Which are you working on?','velocity','height');
burntime=fuelmass/q;
m0=emptymass+fuelmass;
if check==1
    height=zeros(313,3);
    height(100,1)=25822;
    height(114,2)=28946;
    height(127,3)=30489;
else
    height=zeros(313,3);
end
home
%
% Calculation section
%
profile=1;
while maxheight(profile) < maximumheight
    burntime(profile)=round(fuelmass(profile)/q);
    m0=emptymass+fuelmass(profile);
    %
    % Calculations while rocket is burning fuel
    %
    for t=1:burntime(profile)
        time(t,profile)=t;
        % need to enter the equation for velocity
        vel(t,profile)=u*log((m0)/(m0-(q*t)))-(g*t);
        if check ~=1
            % need to enter the equation for height
            height(t,profile)=((u/q)*(m0-(q*t)))*((log(m0-(q*t))))+(u*t*(log(m0)+1))-((g*(t^2))/2)-(((m0*u)/q)*log(m0));
        end
        if maxvel(profile) < vel(t,profile)
            maxvel(profile)=vel(t,profile);
            maxveltime(profile)=t;
        end
        if maxheight(profile)<height(t,profile)
            maxheight(profile)=height(t,profile);
            maxheighttime(profile)=t;
        end
    end
    tpeak(profile)=burntime(profile)+(vel(burntime(profile),profile)/g);
    hpeak(profile)=height(burntime(profile),profile)+((vel(burntime(profile),profile)^2)/(2*g));
    thit(profile)=tpeak(profile)+sqrt((2*hpeak(profile))/g);
    thit(profile)=round(thit(profile));
    %
    % Calculation when rocket is out of fuel
    %
    for t=burntime(profile)+1:thit(profile)
        time(t,profile)=t;
        vel(t,profile)=vel(burntime(profile),profile)-g*(t-burntime(profile));
        height(t,profile)=height(burntime(profile),profile)+vel(burntime(profile),profile)*(t-burntime(profile))-(g*(t-burntime(profile))^2)/2;
        if maxvel(profile) < vel(t,profile)
            maxvel(profile)=vel(t,profile);
            maxveltime(profile)=t;
        end
        if maxheight(profile)<height(t,profile)
            maxheight(profile)=height(t,profile);
            maxheighttime(profile)=t;
        end
    end
    profile=profile+1;
    maxheight(profile)=maxheight(profile-1);
    maxvel(profile)=maxvel(profile-1);
    fuelmass(profile)=fuelmass(profile-1)+addfuel;
end
if check==1
    height=zeros(313,0);
    disp('velocity')
    disp(vel(275:300,:))
    fprintf('if your values for velocity are correct,\n')
    fprintf('show them to the TA and then \n')
    fprintf('enter the equation for height\n')
else
    height(275:300,:)
    fprintf('\nif your values for height are correct,\n')
fprintf('you successfully completed this section\n')
end