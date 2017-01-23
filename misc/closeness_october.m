%% Load data
V = O00U;
%% remove non-connected nodes
active_nodes = or(sum(V)~=0,transpose(sum(V,2)~=0));
active_node_indices = find(active_nodes);
non_active_nodes = ~active_nodes;
non_active_node_indices = find(non_active_nodes);

if sum(non_active_nodes)>0
   V = V(active_node_indices,active_node_indices);
   fprintf('\nNOTE: the following non-connected nodes are removed from the graphs:\n')
   disp(non_active_node_indices)
end
%% Calc average closeness
C = closeness(V);
% Remove any inf values
c = C(~isinf(C));
c_ave = sum(c);
