clear;clc;

name = input('What is your name? ','s');
age = input('What is your age? ');
city = input('What is your City? ','s');
state = input('What is your State? ','s');
zipcode = input('What is your ZipCode? ');

fprintf('Name: %s\nAge: %i\nCity: %s\nState: %s\nZip Code: %i\n',name,age,city,state,zipcode);

correct = menu('Is this information correct?','Yes!','No!');

if correct == 1;
    fprintf('Congratulations for entering the information correctly!\n');
else
    wrong = menu('Which piece of information is incorrect? ','Name','Age','City','State','Zip Code');
    if wrong == 1;
        name = input('What is your name? ','s');
    elseif wrong == 2;
        age = input('What is your age? ');
    elseif wrong == 3;
        city = input('What is your City? ','s');
    elseif wrong == 4;
        state = input('What is your State? ','s');
    elseif wrong == 5;
        zipcode = input('What is your Zip Code? ');
    end
    fprintf('Name: %s\nAge: %i\nCity: %s\nState: %s\nZip Code: %i\n',name,age,city,state,zipcode);
end





