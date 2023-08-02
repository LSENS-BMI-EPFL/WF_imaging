
%% Start acquisition
clear all
close all
warning('off', 'all')
rundir = cd;

if isempty(gcp)
    p = parpool('local', 1, 'IdleTimeout', Inf);    
end

q = parallel.pool.DataQueue;
afterEach(q, @disp);

f = parfeval(@capture_video, 1, q);

%% End acquisition

imaqreset
delete(gcp('nocreate'))
cancel(f)
cd(rundir)
warning('on', 'all')
