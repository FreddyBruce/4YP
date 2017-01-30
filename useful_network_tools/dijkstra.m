%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implements the Dijkstra shortest path algorithm
% INPUTS: adj - adjacency matrix
%         s - source node
%         target - target node (if t == [] then calcs all distances and
%         paths
% OUTPUTS:dist - distance
%         P - path from s to target

function [dist,P]=dijkstra(adj,s,target)

% initialize distances
n=length(adj);            % number of nodes
adjL=adj2adjL(adj);       % list of neighbors

dist=inf(1,n);            % unkown distance from s to all nodes
dist(s)=0;                % distance from s to s

previous=[1:n; inf(1,n)]';  % {i: inf}, i=1:n, inf -> not assigned
S=cell(1,n); % shortest path sequence


Q= 1:n; % all unvisited vertices, entire graph
while ~isempty(Q) 
    % get min dist member among unvisited vertices
    [dmin,ind]=min(dist(Q));
    u=Q(ind);
    
    % termination condition - save source-u path
    S{u}=[];
    t=u;
    while not(isempty(find(previous(:,1)==t)))  % t in previous.keys():
        % insert u at the beginning of S
        S{u}=[t S{u}];
        t=previous(t,2);
    end
    if ~isempty(target) && u==target
        dist=dist(u); P=S{u};
        return
    end            
    
    % =========================================
    Q=purge(Q,u);  % remove u from Q
    for v=1:length(adjL{u})   % across all neighbors of u
        v=adjL{u}(v);        
        alt=dist(u)+adj(u,v);
        if alt < dist(v)
            dist(v)=alt;
            previous(v,2)=u;
        end
    end
end

P=S;