function wf_setup(trigger)

%%% Function to assign inputs and outputs for widefield imaging. Must run
%%% on a different session than the stim session and needs 3 ao ports for
%%% dual color imaging. Trigger option is necessary for single trial imaging, 
%%% and skipped for continuous imaging-- Pol Bech Aug 2023

    arguments
        trigger = 0;
    end
    global WF_S

    WF_S = daq('ni');
    addoutput(WF_S, 'Dev3', 'ao0', 'Voltage'); % WF Camera output
    addoutput(WF_S, 'Dev3', 'ao1', 'Voltage'); % LED1 output
    addoutput(WF_S, 'Dev3', 'ao2', 'Voltage'); % LED2 output
    WF_S.Rate = 100000;

    if trigger % Necessary for trial based WF imaging
        addtrigger(WF_S, 'Digital', 'StartTrigger', 'External', 'Dev3/PFI0');
        WF_S.DigitalTriggerTimeout = Inf;
    end
    
end