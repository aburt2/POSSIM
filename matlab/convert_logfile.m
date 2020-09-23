function converted_log = convert_logfile(logsout)
%Convert logsout file to be closer to the old simulink dataset

%Find number of elements
numElement = logsout.numElement();

%Make empty classes
%Current
currentN = block('Current Neutral',0,0,0);
currentPA = block('Current Phase A',0,0,0);
currentPB = block('Current Phase B',0,0,0);
currentPC = block('Current Phase C',0,0,0);

%Iterate
for n=1:numElement 
    temp = logsout.getElement(n);
    temp_str = temp.BlockPath.getBlock(1);
    
    
end

converted_log = 0;
end

