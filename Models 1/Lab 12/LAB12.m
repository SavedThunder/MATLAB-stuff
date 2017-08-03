clear;close all;

message = input('What message would you like to hide? ','s');
message = double(message);
bin_message = dec2bin(message,8);
bin_message = bin_message';
bin_message = bin_message(:);
bin_message = bin_message';
[R,C] = size(bin_message);


Pic = imread('Cat','png');
imshow(Pic);

CodePic = Pic;
[row,col] = size(CodePic);

if size(message) > size(CodePic)
    error('Your message is too big')
end
i = 1;
for k = 1:row
    for q = 1:col
        if strcmp(bin_message(i),'1') && (Pic(k,q) == 255)
            CodePic(k,q) = Pic(k,q) - 1;
        elseif strcmp(bin_message(i),'1') && (CodePic(k,q) < 255 )
            CodePic(k,q) = Pic(k,q) + 1;
        elseif strcmp(bin_message(i),'0')
            CodePic(k,q) = Pic(k,q);
        end
        i = i + 1;
        if i > R * C
            break
        end
    end
    if i > R * C
        break
    end
end

figure; imshow(Pic)
title('Original');
figure; imshow(CodePic)
title('Hidden');

imwrite(CodePic,'CodedCat.png');




