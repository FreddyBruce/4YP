%% Data Generation Dynamic
clear all
% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% Add cmmDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF');
addpath(filePattern3);

month = 'm1';
V.(month) = get_adjacency_from_csv('data.csv',151,2000,01,02);


% Running commDetNMF

[P.(month),g.(month),w,h,max_rank, invbeta] = commDetNMFInitial(V.(month));
ib.(month) = invbeta;
W.(month) = w;
H.(month) = h;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:11
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V.(month) = get_adjacency_from_csv('data.csv',151,2000,i,i+1);
    % Running commDetNMF
    [P.(month),g.(month),w,h,max_rank, invbeta] = commDetNMFInitial(V.(month),max_rank,w,h,invbeta);
    ib.(month) = invbeta;
    W.(month) = w;
    H.(month) = h;
end