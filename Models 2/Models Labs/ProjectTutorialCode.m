%*************Step 1:  This piece of code goes in the FirstGuiOpeningFnc **************

%The Opening Function Sets up how FirstGui looks it is first opened

axes(handles.axes1);  % Point to the top plot tagged as axes1
% Plot a 1 Hz sine wave with amplitude of 5
t = 0:1e-6:1; y = 5*sin(2*pi*t);
plot(t,y); axis([0 1 -10 10]);

axes(handles.axes2);  % Point to the bottom plot tagged as axes2
% Plot a 1 Hz cosine wave with amplitude of 1
t = -1:0.001:1; y = cos(2*pi*t); plot(t,y); title('cos(2*pi*t)');


% **********Step 2:  This piece of code goes under GraphMenu_Callback****************

% This will read the selection from the popup menu and plot the indicated function
axes(handles.axes2);    % Makes axes2 the selected plot window
cla;                    % Clears axes2

menu_choice = get(handles.GraphMenu, 'Value');  % Get user choice from pop-up menu tagged as menu1
switch menu_choice
    case 1
        t = -1:0.001:1; y = cos(2*pi*t); plot(t,y); title('cos(2*pi*t)');
    case 2
        t = -2*pi:0.001:2*pi; y = tan(t); 
        plot(t,y); axis([-2*pi 2*pi -10 10]); title('tan(t)');
    case 3
        t = 0.1:0.001:5; y = log(t);
        plot(t,y); title('ln(t)');
end


% ****Step 3:  This piece of code goes under FreqBox_Callback*******

%This function will retrieve the value a user enters in for frequency.  If
%the frequency entered is not a number, it will be set the value to one and user
%will be prompted to enter a number.

freq = str2double(get(handles.FreqBox,'String'));   % Get the frequency from box tagged FreqBox
if isnan(freq)                               % If freq isn't a number over-write it with a 1
    freq = 1;
    set(handles.FreqBox, 'String',1);        % Write a 1 into the box
    errordlg('Input must be a number');      % Tell user to put in a number
    pause(2);
end

amp = get(handles.AmpSlider,'Value');    % Get amplitude from Slider tagged AmpSlider

axes(handles.axes1);    %Select axes1 for plotting
cla;                    %Clear out axes 1

t = 0:1e-6:1;
y = amp*sin(2*pi*freq*t);
plot(t,y); axis([0 1 -10 10]);


%*********Step 4:  This piece of code goes under AmpSlider_Callback********

amp = get(handles.AmpSlider, 'Value');    % Get the new slider value

freq = str2double(get(handles.FreqBox,'String'));  % Get frequency from box tagged FreqBox

axes(handles.axes1);    %Select axes1 for plotting
cla;                    %Clear out axes 1

t = 0:1e-6:1;
y = amp*sin(2*pi*freq*t);
plot(t,y); axis([0 1 -10 10]);

set(handles.AmpBox, 'String',amp);  % Writes value of slider into box tagged AmpBox


