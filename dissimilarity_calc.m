%% Data Generation

% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);


fid = fopen('data.csv','rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

fid = fopen('random_emails_1.csv','rt');
C_random = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

n = 5;
timestep = 0;
L = zeros(n,1);

for i = 1:n
    timestep = timestep + 86400;
    A = get_directed_adjacency(C,151,C{1,3}(1,1),timestep);
    Anull = get_directed_adjacency(C_random,151,C{1,3}(1,1),timestep);
    L(i) = dissimilarity(A,Anull);
end