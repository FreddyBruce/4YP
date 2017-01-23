% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/manufacturingEmails/manufacturingEmails');
addpath(filePattern);


% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'UsefulNetworkTools');
addpath(filePattern2);

% Add cmmDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern3);

% Import CSV data and convert to an adjacency matrix
V = csvToAdjacency(sprintf('month%d.dat',1), 167);

% Setting max rank
max_rank = ceil(size(V,1)/2);
% Running commDetNMF
month = 'm1';
[P.(month),g.(month),W,H,max_rank, invbeta] = commDetNMF2(V, max_rank);
ib.(month) = invbeta;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:7
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V = csvToAdjacency(sprintf('month%d.dat',i), 167);
    % Running commDetNMF
    [P.(month),g.(month),W,H,max_rank,invbeta] = commDetNMF2(V,max_rank,W,H,invbeta);
    ib.(month) = invbeta;
end