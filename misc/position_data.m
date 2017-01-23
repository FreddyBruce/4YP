%% This script generates the data and calculates the concordance.
%% Variables
year = 2000;
mon = 1; % starting month
n = 12; %number of months
position = 'Employee';
%% Data Generation

% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);

% add csvToAdjacency to working directory
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

% Add cmmDetNMF folder to working directory
filePattern3 = fullfile(pwd, 'commDetNMF/Matlab');
addpath(filePattern3);

month = 'm1';
V.(month) = get_emails_sent('sent.csv',151,year,mon,position);

for i = 2:n
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V.(month) = get_emails_sent('sent.csv',151,year,mon+i,position);
end
