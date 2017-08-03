clear;clc;clf
%Wind 
year = xlsread('USdata_WindProduction', 'c2:c23');
quantity = xlsread('USdata_WindProduction', 'e2:e23');
year = year-1991;
poly = polyfit(year,quantity,3);
yfit = polyval(poly,year);
wind_residual = quantity-yfit;
%Solar
year = xlsread('USdata_SolarProduction', 'c2:c23');
quantity2 = xlsread('USdata_SolarProduction', 'e2:e23');
year = year-1991;
poly2 = polyfit(year,quantity2,3);
yfit2 = polyval(poly2,year);
solar_residual = quantity2-yfit2;
%Plotting
subplot(2,1,1)
plot(year,quantity,'r*',year, yfit); hold on;
plot(year, quantity2,'bl*',year,yfit2);
legend('Wind Energy','Wind Residual','Solar Energy','Solar Residual')
xlabel('Year');
ylabel('Quantity (Kilo-Watt Hours, Millions)');
title('Wind and Solar Electricity in the US by Year');
subplot(2,1,2)
bar(year,[solar_residual wind_residual]);
legend('Solar','Wind');
xlabel('Year');
ylabel('Residual');
title('Year vs Residual');