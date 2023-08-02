function vid = capture_video(q)
    global count

    imaqreset
    configfile='C:\Experiment\WideFieldImaging\config.txt';
    [cam, SessionFolder, TrialPrefix] = getHCconfig(configfile);

    if exist([SessionFolder],'dir')==0
        mkdir(SessionFolder)
    end

    count = 0;
    
    vid = videoinput('hamamatsu', 1, cam.CameraMode);
    vid.ROIPosition=[cam.XPos cam.YPos cam.Width cam.Height]; % x, y, width, height
    vid.TriggerRepeat = inf; % default=0, so frame number-1 is the correct value
    vid.FrameGrabInterval = 1;

%     vid.FramesAcquiredFcn = {@save_video, [SessionFolder 'test_vid'], q};
    vid.FramesAcquiredFcn = {@save_video, configfile, q};

    vid.FramesAcquiredFcnCount = 500;
    
    vid.StopFcn = {@save_video, [SessionFolder 'test_vid'], q};

    vid.Timeout = vid.TriggerRepeat+10/cam.FrameRate;

    vid.FramesPerTrigger = 1;
    vid.TriggerFrameDelay = 0;
    triggerconfig(vid,'hardware','RisingEdge', cam.TriggerMode) %% ACTIVATES AT RISE TIME UNTIL TTL SIGNAL OFF

    vid.LoggingMode = 'memory';

    vid_src = getselectedsource(vid);
    vid_src.ExposureTime = cam.Exposure;


    start(vid)

end