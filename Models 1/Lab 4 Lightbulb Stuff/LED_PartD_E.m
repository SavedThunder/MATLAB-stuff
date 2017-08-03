%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%  Lab 4: Pulse Width Modulation to Control LED Light Level
%  The user will be asked to supply the desired period for the sin wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% house cleaning
clear;      % clears out everything in workspace
close all;  % closes all figures
clc;        % clears out the command window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set up communication to DAQ device
fprintf('Setting up connection to DAQ...\n');
devices_found = daq.getDevices;
if isempty(devices_found)
    error('No devices connected: please connect a DAQ device and rerun.');
end
% Set up DAQ Connection to Device
DAQ_Vendor = devices_found.Vendor.ID;                   % determine type of device connected
DAQ_ID = devices_found.ID;                              % determine ID for connected device
DAQ = daq.createSession(DAQ_Vendor);                    % create DAQ session
DAQ.addAnalogOutputChannel(DAQ_ID,0,'Voltage');         % add output voltage channel to play waveform through filter
ch1 = DAQ.addAnalogInputChannel(DAQ_ID,0,'Voltage');    % add input voltage channel to measure voltage
ch1.Range = [-10 10];                                   % set analog input range to -10 to 10V)
DAQ.Rate = 10000;                                       % Set the DAQ sampling rate
DAQ.outputSingleScan(0);                                % ensure DAQ output is 0V
fprintf('Connection established...\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Student Code Starts Here For Part D
% Complete the line of code below to ask the user to enter in the desired
% frequency of the square wave (input statement)
f = input('Input frequency of the square wave: ');
% Complete the line of code below to calculate the period, T, based on f:
T = 1/f;
% Write an fprintf statement to display the computed period to 2 decimal places
fprintf('Period: ', '%0.2f', T);
% Complete the line of code below to prompt the user for a duty cycle
tau = input('Input duty cycle: ');
% Complete the line of code to prompt the user for how long the square wave should last
Tf = input('How long should the square wave last: ');
% Complete the line of code below to create a vector of times, t.
% t should start at 0, increment by 1/DAQ.Rate, and end close to or at Tf
t = 0:1/DAQ.Rate:Tf;
% Complete the line of code below to create a square wave called AppliedVoltage
% using your vector, t, the desired frequency, f, and desired duty
% cycle, tau.  Square wave should vary from 0V to 10V.
AppliedVoltage = 5*square(2*pi*f*t,tau)+5;

% Student Code Ends Here FOR PART D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT EDIT LINES 49-59
% Send the voltage signal (square wave) to the NI myDAQ
AppliedVoltage(end) = 0;
DAQ.queueOutputData(AppliedVoltage');  
% Make it go!!
% Collect the voltage across the resistor using s.startForeground
[Vr, tmeas] = DAQ.startForeground;
% Vr will be a vector of the measured resistor voltage
% timestamps is a vector of times at which the voltage was measured
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Student Code Starts Here For Part E
% Write a plot statement to plot two graphs together on the same plot (not subplot)
% Put tmeas on the x-axis and AppliedVoltage and Vr (resistor voltage) on
% the y-axis.  Add legend, title, and axis labels.
plot(tmeas,Vr,'b'); hold on;
plot(tmeas,AppliedVoltage,'r');
title('Applied and Measured Voltages');
xlabel('Time (sec)');
ylabel('Voltage (volts)');
legend('Measured Voltage','Applied Voltage');
% Add ylim([0 12]) to adjust the y-limits for a better graph
ylim([0 12]);


% Student Code Ends Here for Part E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DAQ.outputSingleScan(0);    % Turn LED Off