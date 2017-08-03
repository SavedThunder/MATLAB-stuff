clear;clc;

M = [-1  2  5; 6  2  -4; 7  0  5];
[nrows, ncols] = size(M);
S = zeros(1,nrows);
for row = 1:nrows
    S(row) = M(row,1);
    for col = 2:ncols
        if M(row,col) < S(row)
            S(row) = M(row,col);
        end
    end
end

