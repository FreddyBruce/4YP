%% Load data
% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'results');
addpath(filePattern);

filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% Load the data in
load('directed_2001.mat')
%% Generate entropy
for i = 1:12
    % Generate stucture names
    m = num2str(i);
    month = strcat('m',m);
    % Calculate entropy between entire months
    E(i,:) = get_entropy_from_soft_mem(P.(month));
    ave_E = mean(E);
    plot(ave_E, 'o');
end
