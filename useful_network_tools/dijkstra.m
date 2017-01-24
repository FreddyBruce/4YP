% Implements the Dijkstra shortest path algorithm
% Returns the distance from a single vertex to all others, doesn't save the path

function d = dijkstra(adj,s)

n=length(adj);
d = inf*ones(1,n); % unkown distance from source to all nodes
d(s) = 0;    % distance from source to source
Q = 1:n;    % node set with shortest paths not found

while not(isempty(Q))
    
    [dmin,ind] = min(d(Q));
    
    for i=1:length(Q)
        alt = d(Q(ind))+adj(Q(ind),Q(i));
        if adj(Q(ind),Q(i))>0 && d(Q(i))>alt % A shorter path has been found
            
            d(Q(i))=d(Q(ind))+adj(Q(ind),Q(i));
            
        end
    end 
    Q = setdiff(Q,Q(ind));
end

