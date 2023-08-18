function save_video(src, obj, config, q)
    global count
    
    [cam, SessionFolder, TrialPrefix] = getHCconfig(config);

    if exist([SessionFolder],'dir')==0
        count=0;
        mkdir(SessionFolder)
    end
    
    count = count+1;

    [data, timestamps] = getdata(src, src.FramesAvailable);
    
    send(q, count);

    save([SessionFolder TrialPrefix '_' num2str(count, '%04d') '.mat' ], 'data', '-v7.3')   
    save([SessionFolder TrialPrefix '_' num2str(count, '%04d') '_timestamps.mat' ], 'timestamps', '-v7.3')
    
end