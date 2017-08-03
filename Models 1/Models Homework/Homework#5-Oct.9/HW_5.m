clear;clc;

x = [1 -2 3 5 4 2];
t = 0;
for k = 1:5
    if x(k)>x(k+1)
        t = x(k);
        x(k)=x(k+1);
        x(k+1)=t;
    end
end
disp(x)
    