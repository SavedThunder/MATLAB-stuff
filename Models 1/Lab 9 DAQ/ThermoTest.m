devices_found = daq.getDevices;
DAQ_ID = devices_found.ID ;
DAQ = daq.createSession('ni');
measurement1 = DAQ.addAnalogInputChannel(DAQ_ID,0,'Voltage');
Measurement2 = DAQ.addAnalogInputChannel(DAQ_ID,1,'Voltage');
AC = DAQ.addAnalogOutputChannel(DAQ_ID,0,'Voltage');
FURNACE = DAQ.addAnalogOutputChannel(DAQ_ID,1,'Voltage');

