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
name=input('enter rocket name: ','s');
while strcmpi(answer,'no')
    unittype=menu('unit type:','SI (g=9.81 m/sec^2)','gravitational(g=32.2 ft/sec^2)');
    if unittype==1
        g=9.81;
    else
        g=32.2;
    end
    if unittype==1
        emptymass=input('empty mass of rocket (kg) = ');
        fuelmass(1)=input('enter the fuel mass (kg) = ');
        q=input('rate at which rocket burns fuel (kg/sec) = ');
        u=input('enter velocity of rocket thrust (m/sec) = ');
        maximumheight=input('enter the maximum height of the rocket must acheive in meters = ');
        addfuel=input('enter the amount of fuel you''d add in kg = ');
    else
        emptymass=input('empty mass of rocket (slugs) = ');
        fuelmass(1)=input('enter the fuel mass (slugs) = ');
        q=input('rate at which rocket burns fuel (slugs/sec) = ');
        u=input('enter velocity of rocket thrust (ft/sec) = ');
        maximumheight=input('enter the maximum height of the rocket must acheive in feet = ');
        addfuel=input('enter the amount of fuel you''d add in slugs = ');
    end
    burntime=fuelmass/q;
    m0=emptymass+fuelmass;
    home
    if unittype==1
        fprintf('gravitational constant = %0.2f m/sec^2\n',g)
        fprintf('empty mass of rocket = %5.1f kg \n',emptymass)
        fprintf('mass of fuel = %5.1f kg \n',fuelmass)
        fprintf('rate at which rocket burns fuel = %5.1f kg/sec \n',q)
        fprintf('velocty of rocket thrust = %5.1f m/sec \n',u)
        fprintf('burn time will be %5.1f seconds \n', burntime)
        fprintf('total initial mass of rocket plus fuel is %5.1f kg \n',m0)
        fprintf('the desired height of the rocket is %8.0f meters \n',maximumheight)
    else
        fprintf('gravitational constant = %0.2f ft/sec^2\n',g)
        fprintf('empty mass of rocket = %5.1f slugs \n',emptymass)
        fprintf('mass of fuel = %5.1f slugs \n',fuelmass)
        fprintf('rate at which rocket burns fuel = %5.1f slugs/sec \n',q)
        fprintf('velocity of rocket thrust = %5.1f ft/sec \n',u)
        frpintf('burn time will be %5.1f seconds \n', burntime)
        fprintf('total initial mass of rocket plus fuel is %5.1f slugs \n',m0)
        fprintf('the desired height of the rocket is %8.0f feet \n',maximumheight)
    end
    % ask if input is correct
   answer=input('is your input correct? yes/no  ','s');
    if strmcpi(answer,'yes')
        answer='yes';
    else
        answer='no';
    end
end
if unittype==1
    fprintf('\nif this is you first time getting this message be sure to look very carefully\n')
    fprintf('at your display.  Is the value of g actually printed?')
    fprintf('\ncongratulations, you found all the errors in the SI section\n')
    fprintf('to find all errors you need to also debug the gravitational section\n')
else
    fprintf('\nif this is you first time getting this message be sure to look very carefully\n')
    fprintf('at your display.  Is the value of "velocity of rocket thrust" correct?')
    fprintf('\ncongratulations, you found all the errors in the gravitational section\n')
    fprintf('to find all errors you need to also debug the SI section\n')
end

