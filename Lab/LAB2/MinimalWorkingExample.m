
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
            sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [50, 0, 0, 0, 29, 0]);  % new corresponding control valuesdisp(measurements); % process measurements
                 
    sendControlsToG1AndDisturbance(29,0);
    Tsimul = 600;
    step_response = zeros(Tsimul+1,1);
    i = 0;
    k = linspace (0,Tsimul,Tsimul+1)';
    step_zakl=-10;
    
    
    while(i<=Tsimul)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 1
        
        %% processing of the measurements and new control values calculation
        disp(measurements(1));
        step_response(i+1)=measurements(1);
        
        %% sending new values of control signals
        sendControlsToG1AndDisturbance(29,step_zakl);
        
     %%   y=[y measurements(1)];
     %%   plot(y)
        
        %% synchronising with the control process
        i=i+1;
        waitForNewIteration(); % wait for new batch of measurements to be ready
        
    end
    step_responsezneg_10=step_response;
        T=table(k,step_response);
    writetable(T,'step_z_neg10','WriteVariableNames',false,'Delimiter','space');
    save('step_responsez_neg10.mat','step_responsezneg_10');

