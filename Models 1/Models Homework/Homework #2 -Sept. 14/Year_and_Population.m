year = xlsread('HW2_WorldPopulation.xlsx', 'A2:A52');
population = xlsread('HW2_WorldPopulation.xlsx', 'B2:B52');
year = year - 1950;
%1st Order
poly1st = polyfit(year,population, 1);
yfit1st = polyval(poly1st,63);
%3nd Order
poly3rd = polyfit(year, population, 3);
yfit3rd = polyval(poly3rd,63);
%5th Order
poly5th = polyfit(year, population, 5);
yfit5th = polyval(poly5th,63);
%Plotting
plot(year,population,'b--', year, yfit5thp,'r');hold on
