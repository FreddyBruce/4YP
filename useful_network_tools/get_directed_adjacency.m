function A = get_directed_adjacency(C, nodes,  t1, deltat)

n = size(C{1, 1}, 1);

% Generate empty adjacency Matrix
A = zeros(nodes);

% Time period
tlower = t1;
tupper = tlower+deltat;


% Generate Adjacency
for k = 1:n
    
    if C{1,3}(k,1) <= tupper && C{1,3}(k,1) >= tlower
        i = C{1, 1}(k, 1);
        j = C{1, 2}(k, 1);
        A(i,j) = A(i,j) + 1;
    end
    
end
end