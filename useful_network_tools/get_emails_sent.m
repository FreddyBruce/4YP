function A = get_emails_sent(filename, nodes, year, month, position)
% read and parse csv file
fid = fopen(filename,'rt');
C = textscan(fid, '%d %D %s', 'Delimiter',',','CollectOutput',false);
fclose(fid);

n = size(C{1, 1}, 1);

% Generate empty adjacency Matrix
A = zeros(nodes,1);

% Time period
tlower = datetime(year,month,01);
tupper = datetime(year,month+1,01);

% Generate Adjacency
for k = 1:n
    if isbetween(C{1,2}(k,1),tlower,tupper) == 1 && strcmp(C{1,3}(k,1), position);
        i = C{1, 1}(k, 1);
        A(i) = A(i) + 1;
    end
    
end
end