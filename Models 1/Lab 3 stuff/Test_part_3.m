clear;clc;clf;
%China Data
chinayear = xlsread('UNdata_TotalElectricity.xlsx', 'A2:A23');
chinaquantity = xlsread('UNdata_TotalElectricity.xlsx', 'E2:E23');
chinayear = chinayear - 1991
chinapoly = polyfit(chinayear, chinaquantity, 3);
chinayfit = polyval(chinapoly, chinayear);