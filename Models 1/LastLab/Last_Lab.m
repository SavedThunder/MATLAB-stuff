clear;clc;
load Weather
count = 0;
YearVector = 1970:1:2014;
for year = YearVector
    count = count + 1;
    Rows = find(W.YEAR == year);
    TotalPRCP(count) = sum(W.PRCP(Rows));
    clear Rows
end
MEAN = mean(TotalPRCP)
MIN = min(TotalPRCP)
MAX = max(TotalPRCP)
plot(YearVector,TotalPRCP,'ro-'); hold on
xlabel('Year')
ylabel('Amount of Precipitation(inches)')
title('Rainfall over the Years')
