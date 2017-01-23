function A = get_directed_adjacency_from_csv(filename, nodes, year, month)
% read and parse csv file
fid = fopen(filename,'rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

n = size(C{1, 1}, 1);

% Generate empty adjacency Matrix
A = zeros(nodes);

% Time period
tlower = datetime(year,month,01);
tupper = datetime(year,month+1,01);

% Generate Adjacency
for k = 1:n
    if isbetween(C{1,3}(k,1),tlower,tupper) == 1;
        i = C{1, 1}(k, 1);
        j = C{1, 2}(k, 1);
        A(i,j) = A(i,j) + 1;
    end
    
end
end