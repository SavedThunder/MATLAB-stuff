%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab_09_Thermostat_2.m - <Team Members> - <Date>
% Description: This script will simulate the operation of a thermostat,
% utilizing the NI myDAQ and a simple LM335 temperature sensor.  The
% voltage from the sensor will be read in and converted to a temperature
% value.  The script will then determine, based on the temperature, whether
% to turn on the air conditioning (if it is too hot) or the furnace (if it
% is too cold), which are indicated by LED's.
% Usage: >> Lab_09_Thermostat;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Circuit Connections:
% 5V used to power temperature sensor
% AO0 connected to Red LED
% AO1 connected to Green LED
% AI0+ connected to point between reistor and temperature sensor
% AI0- connected to AGND
% AGND used for circuit grounding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% move to command window
commandwindow;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clean up
clear all;
close all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DAQ setup
fprintf('Setting up connection to DAQ...\n');

% check for connected device, if no device found, inform user and terminate
devices_found = daq.getDevices;
if isempty(devices_found)
    error('No devices connected: please connect a DAQ device and rerun.');
end

% set up DAQ
DAQ_Vendor = devices_found.Vendor.ID;               % determine type of device connected
DAQ_ID = devices_found.ID;                          % determine ID for connected device
DAQ = daq.createSession(DAQ_Vendor);                % create DAQ session
if strcmp(DAQ_Vendor,'digilent')
    DAQ.addAnalogOutputChannel(DAQ_ID,1,'Voltage'); % add output voltage channel to turn on furnace light
    DAQ.addAnalogOutputChannel(DAQ_ID,2,'Voltage'); % add output voltage channel to turn on AC light
    DAQ.addAnalogInputChannel(DAQ_ID,1,'Voltage');  % add input voltage channel to check temperature value
    DAQ.addAnalogInputChannel(DAQ_ID,2,'Voltage');  % add input voltage channel to check thermostat off
else
    DAQ.addAnalogOutputChannel(DAQ_ID,0,'Voltage'); % add output voltage channel to turn on furnace light
    DAQ.addAnalogOutputChannel(DAQ_ID,1,'Voltage'); % add output voltage channel to turn on AC light
    DAQ.addAnalogInputChannel(DAQ_ID,0,'Voltage');  % add input voltage channel to check temperature value
    DAQ.addAnalogInputChannel(DAQ_ID,1,'Voltage');  % add input voltage channel to check thermostat off
end
DAQ.outputSingleScan([0 0]);
fprintf('Connection established...\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION E.1
DesiredTemp = input('What temperature (°F) would you like to maintain? ');
RangeMax = input('What is the max temperature (°F) you would like? ');
RangeMin = input('What is the min temperature (°F) you would like? ');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION E.2
Status = DAQ.inputSingleScan;
TempC = Status(1)*100-276.38;
while Status(2) > 2.5
    Status = DAQ.inputSingleScan;
    TempC = Status(1)*100-276.38;
    TempF = ((9/5)*TempC) + 32;
    clc;
    fprintf('The Temperature is %0.2f (°F)\n',TempF);
    if TempF > RangeMax
        DAQ.outputSingleScan([10,0]);
    elseif TempF < RangeMin
        DAQ.outputSingleScan([0,10]);
    else
        DAQ.outputSingleScan([0,0]);
    end
    pause(1); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SECTION E.3
DAQ.outputSingleScan([0,0]);
fprintf('The Thermostat is no longer running!!!\n');
