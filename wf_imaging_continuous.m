function wf_imaging_continuous

%%% Function to generate and load widefield camera, and excitation led vectors
%%% for continuous widefield imaging -- Pol Bech Aug 2023

    global WF_S Stim_S_SR handles2give trial_number wf_cam_vec LED1_vec LED2_vec WF_FileInfo

    trial_duration = handles2give.trial_duration*2;

    % Path to imaging computer to update ConfigFile

    if getenv('COMPUTERNAME')=='SV-07-051'
        WF_FileInfo.CameraPathConfig         = '\\SV-07-091\Experiment\WideFieldImaging\config.txt';
        WF_FileInfo.CameraPathTemplateConfig = '\\SV-07-091\Experiment\WideFieldImaging\Template\config.txt';
    else
        WF_FileInfo.CameraPathConfig         = '\\SV-07-074\Experiment\WideFieldImaging\config.txt';
        WF_FileInfo.CameraPathTemplateConfig = '\\SV-07-074\Experiment\WideFieldImaging\Template\config.txt';
    end
    WF_FileInfo.n_frames_to_grab         = trial_duration*WF_FileInfo.CameraFrameRate/1000;

    WF_FileInfo.file_name = [char(handles2give.mouse_name) '_' char(handles2give.date) '_' char(handles2give.session_time)];
    WF_FileInfo.savedir = [WF_FileInfo.CameraRoot handles2give.mouse_name '\' WF_FileInfo.file_name '\'];  
        
    FrameRate= WF_FileInfo.CameraFrameRate; % frame rate

    t = 1/Stim_S_SR : 1/Stim_S_SR : ((trial_duration)/1000); % Time vector
    w = WF_FileInfo.CameraExposure; % Pulse width (s)
    d = w/2 : 1/FrameRate : (trial_duration/1000); % Delay vector
    Cam_pulses = pulstran(t,d,'rectpuls',w);

    wf_cam_vec = [zeros(1,2*Stim_S_SR/1000) 5*Cam_pulses(1:end-2*Stim_S_SR/1000)]; %TTL trigger pulses of 5V

    if WF_FileInfo.LED488
        t = 1/Stim_S_SR : 1/Stim_S_SR : ((trial_duration)/1000); % Time vector
        w = 1/FrameRate-0.002; % Pulse width (s)
        d = w/2 : 1/(FrameRate/2) : (trial_duration/1000); % Delay vector
        LED1_pulses = pulstran(t,d,'rectpuls',w);

        LED1_vec = [zeros(1,2*Stim_S_SR/1000) 5*LED1_pulses(1:end-2*Stim_S_SR/1000)];
    else
        LED1_vec = zeros(1, length(wf_cam_vec));
    end

    if WF_FileInfo.LED405
        t = 1/Stim_S_SR : 1/Stim_S_SR : ((trial_duration-1000/WF_FileInfo.CameraFrameRate)/1000); % Time vector
        w = 1/FrameRate-0.002; % Pulse width (s)
        d = w/2 : 1/(FrameRate/2) : (trial_duration/1000); % Delay vector, shift LED2_vec by one frame
        LED2_pulses = pulstran(t,d,'rectpuls',w);

        LED2_vec = [zeros(1,(2+1000/FrameRate)*Stim_S_SR/1000)...
                    5*LED2_pulses(1:end-2*Stim_S_SR/1000)]; %TTL trigger pulses of 5V
    else
        LED2_vec = zeros(1, length(wf_cam_vec));
    end
    
    WriteConfigCtxCam(WF_FileInfo);
    save_wf_config;
    preload(WF_S, [wf_cam_vec; LED1_vec; LED2_vec;]')
    start(WF_S, 'repeatoutput')
    
end