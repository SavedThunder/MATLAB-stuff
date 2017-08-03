clear;clc;clf;
%China Data
chinayear = xlsread('UNdata_TotalElectricity.xlsx', 'C2:C23');
chinaquantity = xlsread('UNdata_TotalElectricity.xlsx', 'E2:E23');
chinapop = xlsread('PopulationData(1).xlsx', 'D2:D23');
chinayear = chinayear - 1991;
chinaPerCapita = chinaquantity./chinapop;
chinapoly = polyfit(chinayear, chinaPerCapita, 3);
chinayfit = polyval(chinapoly, chinayear);
%United States Data
usyear = xlsread('UNdata_TotalElectricity.xlsx', 'C24:C45');
usquantity = xlsread('UNdata_TotalElectricity.xlsx', 'E24:E45');
uspop = xlsread('PopulationData(1).xlsx', 'D24:D45');
usyear = usyear - 1991;
usPerCapita = usquantity./uspop;
uspoly = polyfit(usyear, usPerCapita, 3);
usyfit = polyval(uspoly, usyear);
%Plotting
plot(chinayear, chinaPerCapita,'r*', chinayear, chinayfit,'r'); hold on
plot(usyear, usPerCapita, 'b*', usyear, usyfit,'b');
xlabel('Years');
ylabel('Quantity of Electricity (Kilo Watt Hours) Per Person');
legend('China Usage','China Best Fit','US Usage','US Best Fit');
title('Electricity Usage Per Person China vs. US');