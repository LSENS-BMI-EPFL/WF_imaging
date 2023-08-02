function wf_stop
%%% Function to stop and delete widefield imaging session. After a 0.5s pause 
%%% its ends one last 5s train of pulses as indicator of where to cut the
%%% video in posthoc processing of data. -- Pol Bech Aug 2023

    global WF_S wf_cam_vec LED1_vec LED2_vec
    if WF_S.Running
        stop(WF_S)
        write(WF_S, [zeros(1,50000)', zeros(1,50000)', zeros(1,50000)']) % Pause recording for 0.5s

        % Send one last vector of known length (5s) to save last file of
        % images
        write(WF_S, [wf_cam_vec(1:length(wf_cam_vec)/2); LED1_vec(1:length(wf_cam_vec)/2); LED2_vec(1:length(wf_cam_vec)/2)]')

        % Set all values to 0
        write(WF_S, [zeros(1,50000)', zeros(1,50000)', zeros(1,50000)'])
        
        while WF_S.Running
            continue
        end
        WF_S.delete()
    else
        write(WF_S, [zeros(1,50000)', zeros(1,50000)', zeros(1,50000)'])
    end
end

