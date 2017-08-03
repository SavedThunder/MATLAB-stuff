clear;clc

M = [3  1  5;  4  -4  5; 2  -3  -5;  0  1  -1];
[nrows, ncols] = size(M);
Add = zeros(1,ncols);
Total = 0;
for col = 1:ncols
    for row = 1:nrows
        Add(col) = Add(col) + M(row,col);
    end
    Total = Total + Add(col);
end

