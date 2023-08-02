function [cam, SessionFolder, TrialPrefix]=getHCconfig(configfile)

fid = fopen(configfile);
ConfigStr = fread(fid,'*char')';
fclose(fid);

% Find Camera Mode
IndexStart = strfind(ConfigStr,'HCMode = ') + length('HCMode = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(1)-1;
cam.CameraMode = (ConfigStr(IndexStart:IndexStop));

% Find Trigger Mode
IndexStart = strfind(ConfigStr,'triggerMode = ') + length('triggerMode = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(2)-1;
cam.TriggerMode = (ConfigStr(IndexStart:IndexStop));

% Find fov xpos
IndexStart = strfind(ConfigStr,'xpos = ') + length('xpos = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(3)-1;
cam.XPos = str2num(ConfigStr(IndexStart:IndexStop));

% Find fov ypos
IndexStart = strfind(ConfigStr,'ypos = ') + length('ypos = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(4)-1;
cam.YPos = str2num(ConfigStr(IndexStart:IndexStop));

% Find fov width
IndexStart = strfind(ConfigStr,'width = ') + length('width = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(5)-1;
cam.Width = str2num(ConfigStr(IndexStart:IndexStop));

% Find fov height
IndexStart = strfind(ConfigStr,'height = ') + length('height = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(6)-1;
cam.Height = str2num(ConfigStr(IndexStart:IndexStop));

% Find number of frame to grab
IndexStart = strfind(ConfigStr,'nrOfPicturesToGrab = ') + length('nrOfPicturesToGrab = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(7)-1;
cam.NumFrameGrab = str2num(ConfigStr(IndexStart:IndexStop));

% Find frame rate
IndexStart = strfind(ConfigStr,'frameRate = ') + length('frameRate = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(8)-1;
cam.FrameRate = str2num(ConfigStr(IndexStart:IndexStop));

% Find exposure
IndexStart = strfind(ConfigStr,'exposure = ') + length('exposure = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(9)-1;
cam.Exposure = str2num(ConfigStr(IndexStart:IndexStop));

% Find folder name
IndexStart = strfind(ConfigStr,'folderName = ') + length('folderName = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(10)-1;
SessionFolder = ConfigStr(IndexStart:IndexStop);

% Find filePrefix
IndexStart = strfind(ConfigStr,'filePrefix = ') + length('filePrefix = ');
IndexTemp = strfind(ConfigStr,';');
IndexStop = IndexTemp(11)-1;
TrialPrefix = ConfigStr(IndexStart:IndexStop);


