function save_wf_config
%SAVE_OPTO_CONFIG Save opto_gui configuration at the beginning of session
%and images of the grid coordinates used.
% Encode as json text 

    global folder_name wf_gui WF_FileInfo
    
    wf_config_json = jsonencode(Opto_info, PrettyPrint=true);
    
% Save config file
    fid = fopen([folder_name '\wf_config.json'],'w');
    fprintf(fid, '%s', wf_config_json);
    fclose(fid);

end

