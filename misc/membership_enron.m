%% This script generates the data and calculates the memebership for a given node.
%% Variables
year = 2001;
mon = 1; % starting month
n = 12; %number of months

node = 109;
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

[P.(month),g.(month),w,h,max_rank, invbeta] = commDetNMFInitial(V.(month));
ib.(month) = invbeta;
W.(month) = w;
H.(month) = h;

% Import next Adjacency Matrices and running commDetNMF
for i = 2:n
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V.(month) = get_adjacency_from_csv('data.csv',151,year,mon+i);
    % Running commDetNMF
    [P.(month),g.(month),w,h,max_rank,invbeta] = commDetNMFInitial(V.(month),max_rank,w,h,invbeta);
    ib.(month) = invbeta;
    W.(month) = w;
    H.(month) = h;
end
%% Concordance Memebership Calculation

memb = zeros(1,n-1);

for i = 1:n-1
    % Generate stucture names
    m1 = num2str(i);
    m2 = num2str(i+1);
    month1 = strcat('m',m1);
    month2 = strcat('m',m2);
    % Calculate membership between entire months
    memb(i) = membership(node,g.(month1),g.(month2));
end


plot(memb);
xlabel('Time Step');
ylabel('Concordance');
axis([1 n-1 0 1]);