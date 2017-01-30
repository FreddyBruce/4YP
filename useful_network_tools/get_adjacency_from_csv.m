function A = get_adjacency_from_csv(filename, nodes, year ,month, month2)

%# read and parse csv file
fid = fopen(filename,'rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

n = size(C{1, 1}, 1);

% Generate empty adjacency Matrix
A = zeros(nodes);

% Time period
tlower = datetime(year,month,01);
tupper = datetime(year,month2,01);

% Generate Adjacency
for k = 1:n
    if isbetween(C{1,3}(k,1),tlower,tupper) == 1;
        i = C{1, 1}(k, 1);
        j = C{1, 2}(k, 1);
        A(i,j) = A(i,j) + 1;
        A(j,i) = A(j,i) + 1;
    end
    
end
end