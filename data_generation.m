%% Data Generation

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
V = get_directed_adjacency_from_csv('data.csv',151,2001,01,12);

%remove non-connected nodes
active_nodes = or(sum(V)~=0,transpose(sum(V,2)~=0));
active_node_indices = find(active_nodes);
non_active_nodes = ~active_nodes;
non_active_node_indices = find(non_active_nodes);

if sum(non_active_nodes)>0
   V = V(active_node_indices,active_node_indices);
   fprintf('\nNOTE: the following non-connected nodes are removed from the graphs:\n')
   disp(non_active_node_indices)
end

% Running commDetNMF

[P,g,w,h,max_rank, invbeta] = commDetNMFInitial(V);