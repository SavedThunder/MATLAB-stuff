function MATLAB_Files_Update()
% copy_files copies necessary files to use the NI myDAQ to locations where
% MATLAB will be able to access them.
% USAGE: copy_files();
% created: 31-July-2013
% modified: 19-September-2013

% clean house
clear all;
close all;
clc;
commandwindow;

% get current directory
base_directory = mfilename('fullpath');
slashes = find(base_directory == '\');
base_directory = base_directory(1:max(slashes));

% create C:\MATLAB if it does not exist
cd('C:\');
listing = dir;
found = 0;
for k = 1:length(listing)
    if strcmp(listing(k).name,'MATLAB')
        found = 1;
        break;
    end
end
if ~found
    mkdir('C:\MATLAB');
end
cd(base_directory);

% create DMM.m, stoploop.m and ChannelGroup.m files
mkdir('Data');
cd([base_directory 'Data\']);
write_DMM;
cd(base_directory);

% copy DMM.m and stoploop.m file to C:\MATLAB folder
DMM_Error = 0;
try
    copyfile([base_directory 'Data\DMM.m'],'C:\MATLAB\');
catch err
    fprintf('Error copying DMM.m file.\n');
    DMM_Error = 1;
end
if ~DMM_Error
    fprintf('DMM.m file copied successfully.\n');
end

% update MATLAB path to use this folder
path(path,'C:\MATLAB\');
savepath;

fprintf('\nPress any key to continue...\n');
pause();

% display results
if ~DMM_Error
    fprintf('\nUpdate Successful!\n');
    rmdir('Data','s');
else
    fprintf('\nUpdate Unsuccessful...\n');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File writing functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Write DMM.m file
function write_DMM
fid = fopen('DMM.m','w');
fprintf(fid,'classdef DMM < handle\n');
fprintf(fid,'    %%DMM Interface to National Instruments DMM channels\n');
fprintf(fid,'    %% DMM provides access to the National Instruments DMM channels\n');
fprintf(fid,'    %% available on devices like the myDAQ and Elvis\n');
fprintf(fid,'    %%\n');
fprintf(fid,'    %% obj = DMM(deviceID,min,max) creates an object OBJ representing the device\n');
fprintf(fid,'    %% with the DEVICEID assigned by the National Instruments Measurement\n');
fprintf(fid,'    %% and Automation Explorer, with DMM channel ''''deviceID/dmm''''\n');
fprintf(fid,'    %%\n');
fprintf(fid,'    %% Call the READ method on the object to retrieve the current\n');
fprintf(fid,'    %% dmm reading in Volts.\n');
fprintf(fid,'    %%\n');
fprintf(fid,'    %% This requires the Data Acquisition Toolbox and MATLAB R2010b or\n');
fprintf(fid,'    %% later.  This object does not take exclusive access to the hardware,\n');
fprintf(fid,'    %% and hence can be used in conjunction with a DAQ Session.\n');
fprintf(fid,'    %%\n');
fprintf(fid,'    %% Example:\n');
fprintf(fid,'    %% myDMM = DMM(''''myDAQ'''',''''Voltage'''',-10,10);\n');
fprintf(fid,'    %% \n');
fprintf(fid,'    %% myDMM.read()\n');
fprintf(fid,'    %% ans =\n');
fprintf(fid,'    %%    4.871\n');
fprintf(fid,'    %%\n');
fprintf(fid,'    %% %% release the hardware\n');
fprintf(fid,'    %% clear myDMM\n');
fprintf(fid,'    \n');
fprintf(fid,'    %% Copyright 2013, The MathWorks, Inc.\n');
fprintf(fid,'    \n');
fprintf(fid,'    properties(SetAccess = private)\n');
fprintf(fid,'        Min\n');
fprintf(fid,'        Max\n');
fprintf(fid,'        MeasurementType\n');
fprintf(fid,'    end\n');
fprintf(fid,'    \n');
fprintf(fid,'    methods\n');
fprintf(fid,'        function [obj] = DMM(deviceID, measurementType, min, max)\n');
fprintf(fid,'            if nargin ~= 4\n');
fprintf(fid,'                error(''daq:dmm:badParameter'',''You must provide a valid device identifier, such as ''''Dev1'''', and a measurement type such as ''''Voltage'''' or ''''Current'''', and min and max values such as ''''-10'''', ''''10'''' for a voltage measurement or ''''-2'''', ''''2'''' for a current measurement.'');\n');
fprintf(fid,'            end\n');
fprintf(fid,'            if ~ischar(deviceID)\n');
fprintf(fid,'                error(''daq:dmm:badDeviceID'',''You must provide a valid device identifier, such as ''''Dev1''''.'');\n');
fprintf(fid,'            end\n');
fprintf(fid,'            if ~ischar(measurementType)\n');
fprintf(fid,'                error(''daq:dmm:badMeasurementType'',''You must provide a valid measurement type, such as ''''Voltage'''' or ''''Current''''.'');\n');
fprintf(fid,'            end\n');
fprintf(fid,'            if strcmpi(measurementType, ''Voltage'')\n');
fprintf(fid,'                obj.MeasurementType = ''Voltage'';\n');
fprintf(fid,'            elseif strcmpi(measurementType, ''Current'')\n');
fprintf(fid,'                obj.MeasurementType = ''Current'';\n');
fprintf(fid,'            elseif strcmpi(measurementType, ''Resistance'')\n');
fprintf(fid,'                obj.MeasurementType = ''Resistance'';\n');
fprintf(fid,'            else\n');
fprintf(fid,'                error(''daq:dmm:badMeasurementType'',''You must provide a valid measurement type, such as ''''Voltage'''' or ''''Current''''.'');\n');
fprintf(fid,'            end\n');
fprintf(fid,'            if ~isscalar(min) || ~isnumeric(min) || ~isscalar(max) || ~isnumeric(max)\n');
fprintf(fid,'                error(''daq:dmm:badMinMax'',''You must provide valid scalar numeric min and max values such as ''''-10'''', ''''10'''' for a voltage measurement or ''''-2'''', ''''2'''' for a current measurement.'');\n');
fprintf(fid,'            end\n');
fprintf(fid,'            \n');
fprintf(fid,'            obj.Min = min;\n');
fprintf(fid,'            obj.Max = max;\n');
fprintf(fid,'            \n');
fprintf(fid,'            try\n');
fprintf(fid,'                [status,taskHandle] = daq.ni.NIDAQmx.DAQmxCreateTask (char(0),uint64(0));\n');
fprintf(fid,'                obj.throwOrWarnOnStatus(status);\n');
fprintf(fid,'                obj.Task = taskHandle;\n');
fprintf(fid,'\n');
fprintf(fid,'                if strcmp(obj.MeasurementType, ''Voltage'')\n');
fprintf(fid,'                    [status] = daq.ni.NIDAQmx.DAQmxCreateAIVoltageChan (...\n');
fprintf(fid,'                        taskHandle,...                              %% The task handle\n');
fprintf(fid,'                        [deviceID ''/dmm''],...                       %% physicalChannel\n');
fprintf(fid,'                        char(0),...                                 %% nameToAssignToChannel\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Cfg_Default,...    %% terminalConfig\n');
fprintf(fid,'                        double(min),...                             %% minVal\n');
fprintf(fid,'                        double(max),...                             %% maxVal\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Volts,...          %% units\n');
fprintf(fid,'                        char(0));                                   %% customScaleName\n');
fprintf(fid,'                    obj.throwOrWarnOnStatus(status);\n');
fprintf(fid,'                elseif strcmp(obj.MeasurementType, ''Current'')\n');
fprintf(fid,'                    [status] = daq.ni.NIDAQmx.DAQmxCreateAICurrentChan (...\n');
fprintf(fid,'                        taskHandle,...                              %% The task handle\n');
fprintf(fid,'                        [deviceID ''/dmm''],...                       %% physicalChannel\n');
fprintf(fid,'                        char(0),...                                 %% nameToAssignToChannel\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Cfg_Default,...    %% terminalConfig\n');
fprintf(fid,'                        double(min),...                             %% minVal\n');
fprintf(fid,'                        double(max),...                             %% maxVal\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Amps,...           %% units\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Default,...        %% shuntResistorLoc\n');
fprintf(fid,'                        1e-6,...                                    %% extShuntResistorVal\n');
fprintf(fid,'                        char(0));                                   %% customScaleName\n');
fprintf(fid,'                    obj.throwOrWarnOnStatus(status);\n');
fprintf(fid,'                else\n');
fprintf(fid,'                    [status] = daq.ni.NIDAQmx.DAQmxCreateAIResistanceChan (...\n');
fprintf(fid,'                        taskHandle,...                              %% The task handle\n');
fprintf(fid,'                        [deviceID ''/dmm''],...                       %% physicalChannel\n');
fprintf(fid,'                        char(0),...                                 %% nameToAssignToChannel\n');
fprintf(fid,'                        double(0),...                               %% minVal - forced to 0 despite what the user enters\n');
fprintf(fid,'                        double(max),...                             %% maxVal\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Ohms,...           %% units\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_2Wire,...          %% resistanceConfig\n');
fprintf(fid,'                        daq.ni.NIDAQmx.DAQmx_Val_Internal,...       %% currentExcitSource\n');
fprintf(fid,'                        double(1e-3),...                            %% currentExcitVal\n');
fprintf(fid,'                        char(0));                                   %% customScaleName\n');
fprintf(fid,'                    obj.throwOrWarnOnStatus(status);\n');
fprintf(fid,'                end\n');
fprintf(fid,'            \n');
fprintf(fid,'            catch e\n');
fprintf(fid,'                if strcmp(e.identifier,''MATLAB:undefinedVarOrClass'')\n');
fprintf(fid,'                    %% Check on DAQ not present\n');
fprintf(fid,'                    if ~license(''test'',''data_acq_toolbox'')\n');
fprintf(fid,'                        error(''daq:dmm:requiresDAQ'',''This requires the Data Acquisition Toolbox.  For more information, visit the <a href="http://www.mathworks.com/products/daq">Data Acquisition Toolbox web page</a>.'');\n');
fprintf(fid,'                    end\n');
fprintf(fid,'                    \n');
fprintf(fid,'                    %% Check release -- requires R2010b or later\n');
fprintf(fid,'                    releaseVersion = version(''-release'');\n');
fprintf(fid,'                    year = str2double(releaseVersion(1:end-1));\n');
fprintf(fid,'                    releaseInYear = releaseVersion(end);\n');
fprintf(fid,'                    if year < 2010 ||...\n');
fprintf(fid,'                            (year == 2010 && strcmpi(releaseInYear,''a''))\n');
fprintf(fid,'                        error(''daq:dmm:requiresR2010bOrLater'',''This requires release R2010b or later.  For more information, visit the <a href="http://www.mathworks.com/products/matlab">MATLAB web page</a>.'');\n');
fprintf(fid,'                    end\n');
fprintf(fid,'                elseif strcmp(e.identifier, ''daq:ni:err200170'')\n');
fprintf(fid,'                    error(''daq:dmm:nodmmchannel'',''This device does not have ''''dmm'''' channels.'');\n');
fprintf(fid,'                end\n');
fprintf(fid,'                \n');
fprintf(fid,'                [~] = daq.ni.NIDAQmx.DAQmxClearTask(obj.Task);\n');
fprintf(fid,'                obj.Task = [];\n');
fprintf(fid,'                rethrow(e)\n');
fprintf(fid,'            end\n');
fprintf(fid,'        end\n');
fprintf(fid,'        \n');
fprintf(fid,'        function [data] = read(obj)\n');
fprintf(fid,'                [status,data,~,~] =...\n');
fprintf(fid,'                    daq.ni.NIDAQmx.DAQmxReadAnalogF64(...\n');
fprintf(fid,'                    obj.Task,...                                                    %% taskHandle\n');
fprintf(fid,'                    int32(1),...                                                    %% numSampsPerChan\n');
fprintf(fid,'                    1.0,...                                                         %% timeout\n');
fprintf(fid,'                    uint32(daq.ni.NIDAQmx.DAQmx_Val_GroupByScanNumber),...          %% fillMode\n');
fprintf(fid,'                    zeros(1,1),...                                                  %% readArray \n');
fprintf(fid,'                    uint32(1),...                                                   %% arraySizeInSamps\n');
fprintf(fid,'                    int32(0),...                                                    %% sampsPerChanRead\n');
fprintf(fid,'                    uint32(0));                                                     %% reserved\n');
fprintf(fid,'            obj.throwOrWarnOnStatus(status);\n');
fprintf(fid,'        end\n');
fprintf(fid,'        \n');
fprintf(fid,'        function delete(obj)\n');
fprintf(fid,'            if ~isempty(obj.Task)\n');
fprintf(fid,'                [~] = daq.ni.NIDAQmx.DAQmxClearTask(obj.Task);\n');
fprintf(fid,'                obj.Task = [];\n');
fprintf(fid,'            end\n');
fprintf(fid,'        end\n');
fprintf(fid,'    end\n');
fprintf(fid,'    \n');
fprintf(fid,'    properties(GetAccess = private,SetAccess = private)\n');
fprintf(fid,'        Task = [];\n');
fprintf(fid,'    end\n');
fprintf(fid,'    \n');
fprintf(fid,'    methods(Static, Access = private)\n');
fprintf(fid,'        function throwOrWarnOnStatus( niStatusCode )\n');
fprintf(fid,'            if niStatusCode == daq.ni.NIDAQmx.DAQmxSuccess\n');
fprintf(fid,'                return\n');
fprintf(fid,'            end\n');
fprintf(fid,'            \n');
fprintf(fid,'            %% Capture the extended error string\n');
fprintf(fid,'            %% First, find out how big it is\n');
fprintf(fid,'            [numberOfBytes,~] = daq.ni.NIDAQmx.DAQmxGetExtendedErrorInfo('' '', uint32(0));\n');
fprintf(fid,'            %% Now, get the message\n');
fprintf(fid,'            [~,extMessage] = daq.ni.NIDAQmx.DAQmxGetExtendedErrorInfo(blanks(numberOfBytes), uint32(numberOfBytes));\n');
fprintf(fid,'            \n');
fprintf(fid,'            if niStatusCode < daq.ni.NIDAQmx.DAQmxSuccess\n');
fprintf(fid,'                %% Status code is less than 0 -- It is a NI-DAQmx error, throw an error\n');
fprintf(fid,'                errorToThrow = MException(sprintf(''daq:ni:err%%06d'',-1 * niStatusCode),...\n');
fprintf(fid,'                    ''NI Error %%06d:\\n%%s'', niStatusCode,extMessage);\n');
fprintf(fid,'                throwAsCaller(errorToThrow)\n');
fprintf(fid,'            else\n');
fprintf(fid,'                %% It is a NI-DAQmx error, warn\n');
fprintf(fid,'                warning(sprintf(''daq:ni:warn%%06d'',niStatusCode),...\n');
fprintf(fid,'                    ''NI Warning %%06d:\\n%%s'',niStatusCode,extMessage);\n');
fprintf(fid,'            end\n');
fprintf(fid,'        end\n');
fprintf(fid,'    end\n');
fprintf(fid,'end\n');
fclose(fid);
