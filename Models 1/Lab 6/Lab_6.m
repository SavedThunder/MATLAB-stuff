clear;clc;

rng('shuffle')

rollnumber = input('How many times would you like to play? ');
number = [0 0 0 0 ];

for k = 1:rollnumber
    dice = randi([1 6],[1 5]);
    dice = sort(dice);
    
    if dice(1) == dice(5)
       number(1)=number(1)+1;
       roll='Five of a kind';
    elseif (dice(1)==dice(4))||(dice(2)==dice(5))
        number(2)=number(2)+2;
        roll='Four of a kind';
    elseif (dice(1)==dice(3))||(dice(2)==dice(4))||(dice(3)==dice(5));
        number(3)=number(3)+1;
        roll='Three of a kind';
    elseif (dice(1)==dice(2))||(dice(2)==dice(3))||(dice(3)==dice(4))||(dice(4)==dice(5))
        number(4)=number(4)+1;
        roll='Pair';
    else
    end
    
 
end
probability =[0 0 0 0];
for r = 1:4
    probability(r) = (number(r)/rollnumber)*100;
   
end

fprintf('The Probability of Rolling a Five of a Kind is: %0.2f%%\n',probability(1));
fprintf('The Probability of Rolling a Four of a Kind is: %0.2f%%\n',probability(2));
fprintf('The Probability of Rolling a Three of a Kind is: %0.2f%%\n',probability(3));
fprintf('The Probability of Rolling a Pair is: %0.2f%%\n',probability(4));
    
