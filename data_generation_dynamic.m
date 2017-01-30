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


V = get_adjacency_from_csv('data.csv',151,2001,01,02);


% Running commDetNMF
month = 'm1';
[P.(month),g.(month),W,H,max_rank, invbeta] = commDetNMFInitial(V);
ib.(month) = invbeta;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:11
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V = get_adjacency_from_csv('data.csv',151,2000,i,i+1);
    % Running commDetNMF
    [P.(month),g.(month),W,H,max_rank,invbeta] = commDetNMFInitial(V,max_rank,W,H,invbeta);
    ib.(month) = invbeta;
end