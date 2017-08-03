clear;clc

temperature = input('What is the temperature(C°) of the reactor? ');
pressure = input('What is the pressure(atm) of the reactor? ');

if temperature>355 || pressure>0.100;
    reactor = 'MELTDOWN';
elseif temperature > 345 || pressure > 0.095;
    reactor = 'VERY SEVERE';
elseif temperature > 335 || pressure  > 0.090;
    reactor = 'SEVERE';
elseif temperature > 325 || pressure > 0.085;
    reactor = 'MODERATE';
else
    reactor = 'NORMAL';
end

fprintf('The reactor condition is: %s\n', reactor);
