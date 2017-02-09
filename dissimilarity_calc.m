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

C{1,3} = datenum(C{1,3});
C_random{1,3} = datenum(C_random{1,3});

n = 1000;
timestep = 0;
L = zeros(n,1);

for i = 1:n
    s = num2str(i);
    step = strcat('s',s);
    timestep = timestep + 60;
    A.(step) = get_directed_adjacency(C,151,C{1,3}(4000,1),timestep);
    Anull.(step) = get_directed_adjacency(C_random,151,C_random{1,3}(4000,1),timestep);
    L(i) = dissimilarity(A.(step),Anull.(step));
end