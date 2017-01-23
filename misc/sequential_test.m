% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/bymonth');
addpath(filePattern);


% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% Add commDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern3);

% Running commDetNMF
frame = 'm1';
% Import CSV data and convert to an adjacency matrix
V = get_adjacency_from_csv2('m1.dat', 183);
% Setting max rank
max_rank = ceil(size(V,1)/2);
% Running commDetNMF in order to intialise H and W
[P,g,W,H,max_rank, invbeta] = commDetNMFDynamic(V, max_rank);
ib.(frame) = invbeta;


% Running commDetNMF data point by data point
for i = 2:3
    % Generating structure name
    m = num2str(i);
    frame = strcat('m',m);
    % Importing next adjacency matrix
    V = get_adjacency_from_csv2(sprintf('m%d.dat',i), 183);
    % Running commDetNMF
    [P,g,W,H,max_rank,invbeta] = commDetNMFDynamic(V,max_rank,W,H,invbeta);
    ib.(frame) = invbeta;

end