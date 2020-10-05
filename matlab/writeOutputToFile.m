phaseNames = {'Phase A', 'Phase B', 'Phase C', 'Neutral'};
modelName = 'FordeModel/';
blockRMS = 'RMS (discrete)';
blockFourier = 'Discrete Fourier';
numHouses = size(householdNames, 1);
numBackboneSegs = size(backboneNames, 1);
out = zeros(36+3*numHouses+6*numBackboneSegs,1);
counter = 0;
% phase voltages
for i=0:3
    str_RMS = [modelName 'Voltage ' phaseNames{i+1} '/' blockRMS];
    str_DF = [modelName 'Voltage ' phaseNames{i+1} '/' blockFourier];
    out(3*i+1) = logsout.find('BlockPath',str_RMS).getElement('RMS1').Values.Data;
    out(3*i+2) = logsout.find('BlockPath',str_DF).getElement('DF1').Values.Data;
    out(3*i+3) = logsout.find('BlockPath',str_DF).getElement('DF2').Values.Data;
    counter = counter+3;
end

% phase currents
for i=0:3
    str_RMS = [modelName 'Current ' phaseNames{i+1} '/' blockRMS];
    str_DF = [modelName 'Current ' phaseNames{i+1} '/' blockFourier];
    out(12+3*i+1) = logsout.find('BlockPath',str_RMS).getElement('RMS1').Values.Data;
    out(12+3*i+2) = logsout.find('BlockPath',str_DF).getElement('DF1').Values.Data;
    out(12+3*i+3) = logsout.find('BlockPath',str_DF).getElement('DF2').Values.Data;
    counter = counter+3;
end

% end of line voltages
for i=0:3
    str_RMS = [modelName 'Distribution Network/' 'Voltage ' phaseNames{i+1} '/' blockRMS];
    str_DF = [modelName 'Distribution Network/' 'Voltage ' phaseNames{i+1} '/' blockFourier];
    out(24+3*i+1) = logsout.find('BlockPath',str_RMS).getElement('RMS1').Values.Data;
    out(24+3*i+2) = logsout.find('BlockPath',str_DF).getElement('DF1').Values.Data;
    out(24+3*i+3) = logsout.find('BlockPath',str_DF).getElement('DF2').Values.Data;
    counter = counter+3;
end

% individual household voltages
for i=0:(numHouses-1)
    str_RMS = [modelName 'Distribution Network/' householdNames{i+1} '/Voltage Measurement/' blockRMS];
    str_DF = [modelName 'Distribution Network/' householdNames{i+1} '/Voltage Measurement/' blockFourier];
    out(36+3*i+1) = logsout.find('BlockPath',str_RMS).getElement('RMS1').Values.Data;
    out(36+3*i+2) = logsout.find('BlockPath',str_DF).getElement('DF1').Values.Data;
    out(36+3*i+3) = logsout.find('BlockPath',str_DF).getElement('DF2').Values.Data;
    counter = counter+3;
end

indexNow = counter;

% individual line segment voltages
for i=0:(numBackboneSegs-1)
    str_AB = [modelName 'Distribution Network/' backboneNames{i+1} '/Voltage_AB/' blockFourier];
    str_BC = [modelName 'Distribution Network/' backboneNames{i+1} '/Voltage_BC/' blockFourier];
    str_CA = [modelName 'Distribution Network/' backboneNames{i+1} '/Voltage_CA/' blockFourier];
    out(indexNow+6*i+1) = logsout.find('BlockPath',str_AB).getElement('DF1').Values.Data;
    out(indexNow+6*i+2) = logsout.find('BlockPath',str_AB).getElement('DF2').Values.Data;
    out(indexNow+6*i+3) = logsout.find('BlockPath',str_BC).getElement('DF1').Values.Data;
    out(indexNow+6*i+4) = logsout.find('BlockPath',str_BC).getElement('DF2').Values.Data;
    out(indexNow+6*i+5) = logsout.find('BlockPath',str_CA).getElement('DF1').Values.Data;
    out(indexNow+6*i+6) = logsout.find('BlockPath',str_CA).getElement('DF2').Values.Data;
end

save([logDir 'temp_output.txt'], 'out', '-ascii');

