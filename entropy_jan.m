%% Data Generation

% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update/dissi_2001');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% add csvToAdjacency to working directory
filePattern3 = fullfile(pwd, 'commDetNMF');
addpath(filePattern3);

fid = fopen('data_2001.csv','rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

C{1,3} = datenum(C{1,3});


n = 180;
timestep = 1;
start = 7.308523715277778e+05;
finish = start + timestep;
Etotal = zeros(n,1);


for i = 1:n
    A = get_undirected_adjacency(C,151,start,finish);
    P = commDetNMF(A);
    E = get_relative_entropy(P); %total entropy
    E(isnan(E)) = 0;
    Etotal(i) = sum(E);
    fprintf('%d\n',i);
    finish = finish + timestep;
end