%% Data Generation

% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update/dissi_2000');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);


fid = fopen('data_2000.csv','rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

fid = fopen('null_1_2000.csv','rt');
C_null_1 = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

fid = fopen('null_2_2000.csv','rt');
C_null_2 = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

fid = fopen('null_3_2000.csv','rt');
C_null_3 = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);


C{1,3} = datenum(C{1,3});
C_null_1{1,3} = datenum(C_null_1{1,3});
C_null_2{1,3} = datenum(C_null_2{1,3});
C_null_3{1,3} = datenum(C_null_3{1,3});

n = 1000;
timestep = 0;
L = zeros(n,3);

for i = 1:n
    timestep = timestep + 60;
    A = get_directed_adjacency(C,151,C{1,3}(21,1),timestep);
    A_null_1 = get_directed_adjacency(C_null_1,151,C_null_1{1,3}(1,1),timestep);
    A_null_2 = get_directed_adjacency(C_null_2,151,C_null_2{1,3}(1,1),timestep);
    A_null_3 = get_directed_adjacency(C_null_3,151,C_null_3{1,3}(1,1),timestep);
    L(i,1) = dissimilarity(A,A_null_1);
    L(i,2) = dissimilarity(A,A_null_2);
    L(i,3) = dissimilarity(A,A_null_3);
end