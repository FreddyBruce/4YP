function [P,g,W,H] = commDetNMFSequential(filename, nodes)
% Adding paths to other subfolders
filePattern = fullfile(pwd, 'Data/enronmail');
addpath(filePattern);

filePattern3 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern3);

% Read in csv file
M = csvread(filename, nodes);

n = size(M, 1);

% Running commDetNMF for data point one
A = zeros(nodes);
i = M(1, 2);
j = M(1, 3);
A(i,j) = 1;
A(j,i) = 1;

[P,g,W,H,max_rank, invbeta] = commDetNMFDynamic(A, 92);

for k = 2:n
    A = zeros(nodes);
    i = M(k, 2);
    j = M(k, 3);
    A(i,j) = 1;
    A(j,i) = 1;
    
    [P,g,W,H,max_rank,invbeta] = commDetNMFDynamic(A,max_rank,W,H,invbeta);
    
    
end
end