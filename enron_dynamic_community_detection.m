function [P,V,g,W,H,ib] = enron_dynamic_community_detection(window,step,n)
%% Variables
start = 7.304889687500000e+05; 
finish = start + window;
%% Adding required file patterns
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);

filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);

filePattern3 = fullfile(pwd, 'commDetNMF');
addpath(filePattern3);
%% Load emails
fid = fopen('entire.csv','rt');
C = textscan(fid, '%d %d %D', 'Delimiter',',','CollectOutput',false);
fclose(fid);

C{1,3} = datenum(C{1,3}); % Convert to serial datetime
%% Load Adjacency Matrix & Run CommDetNMF
month = 'm1';
V.(month) = get_directed_adjacency(C,151,start,finish);
%Run comDetNMF
[P.(month),g.(month),w,h,max_rank, invbeta] = commDetNMFInitial(V.(month));
ib.(month) = invbeta;
W.(month) = w;
H.(month) = h;

for i = 2:n
    % Increment start and finish
    start = start + step;
    finish = finish +step;
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    % Importing next adjacency matrix
    V.(month) = get_directed_adjacency(C,151,start,finish);
    % Running commDetNMF
    [P.(month),g.(month),w,h,max_rank, invbeta] = commDetNMFInitial(V.(month),max_rank,w,h,invbeta);
    ib.(month) = invbeta;
    W.(month) = w;
    H.(month) = h;
end
end