% add get_observation_density to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);


% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/bymonth');
addpath(filePattern);
M = csvread('all.dat');

diffs = get_observation_density(M(1,:));
