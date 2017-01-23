% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/bymonth');
addpath(filePattern);


% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% Add cmmDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern3);



% Running commDetNMF
month = 'm6';
% Import CSV data and convert to an adjacency matrix
V.(month) = csvToAdjacency(sprintf('m%d.dat',6), 183);
% Setting max rank
max_rank = ceil(size(V.(month),1)/2);

[P.(month),g.(month),W.(month),H.(month),max_rank, invbeta] = commDetNMFDynamic(V.(month), max_rank);
ib.(month) = invbeta;
 w = W.(month);
 h = H.(month);
 
 % Import next Adjacency Matrices and running commDetNMF
 for i = 2:11
     % Generating structure name
     m = num2str(i);
     month = strcat('m',m);
     % Importing next adjacency matrix
     V.(month) = csvToAdjacency(sprintf('m%d.dat',i), 183);
     % Running commDetNMF
     [P.(month),g.(month),W.(month),H.(month),max_rank,invbeta] = commDetNMFDynamic(V.(month),max_rank,w,h,invbeta);
     ib.(month) = invbeta;
     w = W.(month);
     h = H.(month);
 end