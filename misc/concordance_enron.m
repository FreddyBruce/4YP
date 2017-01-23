%% This script generates the data and calculates the concordance.
%% Variables
year = 2000;
mon = 1; % starting month
n = 12; %number of months
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
V.(month) = get_adjacency_from_csv('data.csv',151,year,mon);


% Running commDetNMF

[P.(month),g.(month),W,H,max_rank, invbeta] = commDetNMFInitial(V.(month));
ib.(month) = invbeta;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:n
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V.(month) = get_adjacency_from_csv('data.csv',151,year,mon+i);
    % Running commDetNMF
    [P.(month),g.(month),W,H,max_rank,invbeta] = commDetNMFInitial(V.(month),max_rank,W,H,invbeta);
    ib.(month) = invbeta;
end
%% Concordance Calculation

% Calculate the concordance for entire dataset
ave_conc = zeros(1,n-1);
for i = 1:n-1
    % Generate stucture names
    m1 = num2str(i);
    m2 = num2str(i+1);
    month1 = strcat('m',m1);
    month2 = strcat('m',m2);
    % Calculate concordance between entire months
    conc.(month1) = commDetNMFConcordance(g.(month1),g.(month2));
    ave_conc(i) = mean(conc.(month1));
end

plot(ave_conc);
xlabel('Time Step');
ylabel('Concordance');
axis([1 n-1 0 1]);