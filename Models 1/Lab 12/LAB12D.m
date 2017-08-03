clear; close all;clc;

% Pic = imread('Cat','png');
% CodedPic = imread('CodedCat','png');
Pic = imread('Image1','png');
CodedPic = imread('Image2','png');
Pic = double(Pic);
CodedPic = double(CodedPic);

Difference = abs(Pic - CodedPic);
[row, col]= size(Difference);
s1 = size(Difference);
 
Bin_message = '';
Final_message = '';
i = 1;
 
 for r = 1:row
     for c = 1:col
         if Difference(r,c)==1
             Bin_message(i)= '1';
         else
             Bin_message(i) = '0';
         end
         i = i+1;
     end
 end
 
first = 1;
second = 8;
for mess = 1:length(Bin_message)
    if second > length(Bin_message)
        break
    else
    Final_message(mess) = char(bin2dec(Bin_message(first:second)));
    first = first + 8;
    second = second + 8;
    end
end

disp(Final_message)
    
    
