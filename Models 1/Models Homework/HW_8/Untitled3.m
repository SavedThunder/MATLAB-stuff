clear;clc;

Res1 = input('What is the value of resistor 1?');
Res2 = input('What is the value of resistor 2?');
Tol1 = input('What is the tolerance of resistor 1?');
Tol2 = input('What is the tolerance of resistor 2?');
SoVol = input('What is the source voltage?');
AVT1 = input('What is the acceptable voltage tolerance on resistor 1 in percent value?');
AVT2 = input('What is the acceptable voltage tolerance on resistor 2 in percent value?');

Tol1 = Tol1/100;
Tol2 = Tol2/100;
AVT1 = AVT1/100;
AVT2 = AVT2/100;

R1min = Res1 - (Res1 * Tol1);
R1max = Res1 + (Res1 * Tol1);
R2min = Res2 - (Res2 * Tol2);
R2max = Res2 + (Res2 * Tol2);
Range1 = linspace(R1min, R1max, 500);
Range2 = linspace(R2min, R2max, 500);

Voltage1 = (Res1/(Res1 + Res2))*SoVol;
Voltage2 = (Res2/(Res1 + Res2))*SoVol;
Volt_1_min = Voltage1 - (Voltage1 * AVT1);
Volt_1_max = Voltage1 + (Voltage1 * AVT1);
Volt_2_min = Voltage2 - (Voltage2 * AVT2);
Volt_2_max = Voltage2 + (Voltage2 * AVT2);

Results = zeros(500,500);
row = 1;

for R1 = linspace(R1min, R1max, 500);
    col = 1;
    for R2 = linspace(R2min, R2max, 500);
        CalcVolt1 = (R1/(R1 + R2)) * SoVol;
        CalcVolt2 = (R2/(R1 + R2)) * SoVol;
        
        if ((CalcVolt1 >= Volt_1_min) && (CalcVolt1 <= Volt_1_max)) && ((CalcVolt2 >= Volt_2_min) && (CalcVolt2 <= Volt_2_max))
            Results(row,col) = 255;
        end
       col = col + 1;
    end
    row = row + 1;
end

imshow(uint8(Results))

Vector_1 = 1:10000;
Vector_2 = 1:10000;
BadC1 = 0;
BadC2 = 0;

for k = 1:10000
    Vector_1(k) = Res1 + (Tol1 * Res1)/2 * randn(1);
    Vector_2(k) = Res2 + (Tol2 * Res2)/2 * randn(1);
    if (Vector_1(k)> Volt_1_max) || (Vector_1(k) < Volt_1_min)
        BadC1 = BadC1 + 1;
    end
    if (Vector_2(k) > Volt_2_max) || (Vector_2(k) < Volt_2_min)
        BadC2 = BadC2 + 1;
    end
   
end
BadC_Total = BadC1 + BadC2;

figure; hist(Vector_1,100);
xlabel('Resistor Value')
ylabel('Number of Resistors')
title('Numbers of Resistor vs. Resistor Values')
figure; hist(Vector_2,100);
xlabel('Resistor Value')
ylabel('Number of Resistors')
title('Numbers of Resistor vs. Resistor Values')

BadProb = (BadC_Total/10000)*100;
disp('Probability of Bad Circuit = ')
disp(BadProb)