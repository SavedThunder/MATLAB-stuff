clear;clc;clf
year = xlsread('UNdata_TotalElectricity', 'c24:c45');
quantity = xlsread('UNdata_TotalElectricity', 'e24:e45');
year = year-1991;
poly = polyfit(year,quantity,1);
yfit = polyval(poly,year);
residual = quantity-yfit;
subplot(2,1,1)
plot(year,quantity,'red*',year, yfit);
xlabel('Year');
ylabel('Quantity (Kilo-Watt Hours, Millions)');
title('Electricity in the US by Year')
subplot(2,1,2)
bar(year,residual);
xlabel('Year');
ylabel('Residual');
title('Year vs Residual');
