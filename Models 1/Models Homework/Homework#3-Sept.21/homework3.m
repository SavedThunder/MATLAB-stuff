clear;clc;

band1 = menu('What is the color of the first band? ', 'Black','Brown','Red','Orange','Yellow','Green','Blue','Violet','Gray','White');
band2 = menu('What is the color of the second band? ', 'Black','Brown','Red','Orange','Yellow','Green','Blue','Violet','Gray','White');
band3 = menu('What is the color of the third band? ', 'Black','Brown','Red','Orange','Yellow','Green','Blue','Violet','Gray','White');
band4 = menu('What color is the fourth band? ', 'Gold', 'Silver', 'None');

band1 = band1 -1;
band2 = band2 -1;
band3 = band3 -1;

nominal = (band1 * 10 + band2)*10^band3;
tolerance = [0.05 0.10 0.20];
rangemax = nominal + nominal * tolerance(band4);
rangemin = nominal - nominal * tolerance(band4);
fprintf('The nominal value is: %i\n' , nominal);
fprintf('The range of the actual resistor value is %i to %i\n' , rangemin, rangemax);
