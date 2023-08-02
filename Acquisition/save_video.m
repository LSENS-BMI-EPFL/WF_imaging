% function save_video(src, obj, loc, q)
%     global count
%     count = count+1;
%     frames = src.FramesAcquired- src.FramesAcquiredFcnCount;
% 
%     [data, timestamps] = getdata(src, src.FramesAvailable);
%     
% %     send(q, [loc '_data' num2str(count)])
%     if mod(count, 10)==0
%         send(q, data);
%     end
%     save([loc '_data' num2str(count) '.tiff' ], 'data', '-v7.3')   
%     save([loc '_timestamps' num2str(count) '.mat' ], 'timestamps', '-v7.3')
%     
% end
function save_video(src, obj, config, q)
    global count
    
    [cam, SessionFolder, TrialPrefix] = getHCconfig(config);

    if exist([SessionFolder],'dir')==0
        count=0;
        mkdir(SessionFolder)
    end
    
    count = count+1;
    

    [data, timestamps] = getdata(src, src.FramesAvailable);
    
%     if mod(count, 1000)==0
% %         send(q, data);
%         send(q, count);
%     end
    send(q, count);

    save([SessionFolder TrialPrefix '_' num2str(count) '.mat' ], 'data', '-v7.3')   
    save([SessionFolder TrialPrefix '_' num2str(count) '_timestamps.mat' ], 'timestamps', '-v7.3')
    
end