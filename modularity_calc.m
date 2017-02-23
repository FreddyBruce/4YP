%% Data Generation

% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);


fid = fopen('entire.csv','rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

C{1,3} = datenum(C{1,3});


n = 730;
timestep = 1;
start = 730488.968750000;
finish = start + timestep;
Qmax = zeros(n,1);
Q = zeros(n,151);

for i = 1:n
    finish = finish + 1;
    A = get_undirected_adjacency(C,151,start,finish);
    [groups_hist,Q(i,:)] = newman_comm_fast(A);
    Qmax(i) = max(Q(i,:));
    fprintf('%d\n',i);
end