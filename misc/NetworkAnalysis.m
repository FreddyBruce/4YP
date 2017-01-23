% Get path to a sub folder off the current working directory.
filePattern = fullfile(pwd, 'Data/Dolphins/');
addpath(filePattern);


% Import GMl data and convert to an adjacency matix
V = importgml('dolphins.gml');

% Add commDetNMF folder to working directory
filePattern2 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern2);

% Running commDetNMF
%
% Inputs : 
% V: NxN adjacency matrix 
% max_rank: a prior estimation on the maximum number of communities
% (Optional). If left empty the function takes the max rank as half the
% number of nodes.
% W0, H0: prior values for W, H factors (Optional)
%       
% Outputs : 
% P: NxK matrix where each element Pik represents the (normalsed) soft
% memebership score of node-i to each community-k. P captures the
% OVERLAPPING community structure.
%
% g: groups cell array. Each element g{k} contians the node indices of
% community k. Each node i is placed in the community g{k} for which it has
% the maximum Pnk. Therefore g describes the NON-OVERLAPPING structure.
% 
% W, H are the NMF factors (normalised from 0 to 1)
[P,g,W,H,max_rank,invbeta] = commDetNMF(V);