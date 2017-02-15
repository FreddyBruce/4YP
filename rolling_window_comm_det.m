%% Rolling window data generation

% Add cmmDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF');
addpath(filePattern3);

step = 's1';

% Running commDetNMF

[P.(step),g.(step),w,h,max_rank, invbeta] = commDetNMFInitial(A.(step));
ib.(step) = invbeta;
W.(step) = w;
H.(step) = h;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:11
    % Generating structure name
    m = num2str(i);
    step = strcat('s',m);
 
    % Running commDetNMF
    [P.(step),g.(step),w,h,max_rank, invbeta] = commDetNMFInitial(A.(step),max_rank,w,h,invbeta);
    ib.(step) = invbeta;
    W.(step) = w;
    H.(step) = h;
end