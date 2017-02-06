%% Load Data
clear all;
load('directed.mat');
load('undirected.mat');
%% Plot Communities through time
for i = 1:11
    % Generating structure name
    m = num2str(i);
    month = strcat('m',m);
    directed(i) = size(g_d.(month),1);
    undirected(i) = size(g_u.(month),1);
end
plot(directed,'-x');
hold on
plot(undirected,'--mo');
hold off
legend('directed','undirected')
ylabel('Number of Communities')
xlabel('Month')
title('Community sizes for 2001')
%% Concordance
n = 11;
ave_conc_d = zeros(1,n-1);
ave_conc_u = zeros(1,n-1);
for i = 1:n-1
    % Generate stucture names
    m1 = num2str(i);
    m2 = num2str(i+1);
    month1 = strcat('m',m1);
    month2 = strcat('m',m2);
    % Calculate concordance between entire months
    conc_d.(month1) = commDetNMFConcordance(g_d.(month1),g_d.(month2));
    conc_u.(month1) = commDetNMFConcordance(g_u.(month1),g_u.(month2));
    ave_conc_d(i) = mean(conc_d.(month1));
    ave_conc_u(i) = mean(conc_u.(month1));
end

figure
plot(ave_conc_d);
hold on
plot(ave_conc_u);
hold off
title('Average concordance through time');
xlabel('Time Step');
ylabel('Average Concordance');
legend('directed','undirected');
axis([1 n-1 0 1]);
%% Concordance between undirected and directed
n = 11;
ave_conc = zeros(1,n);
for i = 1:n
    % Generate stucture names
    m1 = num2str(i);
    month1 = strcat('m',m1);
    % Calculate concordance between entire months
    conc.(month1) = commDetNMFConcordance(g_d.(month1),g_u.(month1));
    ave_conc(i) = mean(conc.(month1));
end

figure
plot(ave_conc);
title('Average concordance between directed and undirected through time');
xlabel('Time Step');
ylabel('Average Concordance');
axis([1 n-1 0 1]);
%% Entropy
for i = 1:11
    % Generate stucture names
    m = num2str(i);
    month = strcat('m',m);
    % Calculate entropy between entire months
    E_d(i,:) = get_entropy_from_soft_mem(P_d.(month));
    E_u(i,:) = get_entropy_from_soft_mem(P_u.(month));
end
figure
title('Entropy Distribution');

subplot(2,1,1);
plot(E_u, 'o');
title('Undirected');
xlabel('Time Step');
ylabel('Entropy');

subplot(2,1,2);
plot(E_d,'o');
title('Directed');
xlabel('Time Step');
ylabel('Entropy');

for i = 1:11
    [sorted_d,sortingIndices_d] = sort(E_d(i,:),'descend');
    maxValues_d(i,:) = sorted_d(1:20);
    maxValueIndices_d(i,:) = sortingIndices_d(1:20);
    [sorted_u,sortingIndices_u] = sort(E_u(i,:),'descend');
    maxValues_u(i,:) = sorted_u(1:20);
    maxValueIndices_u(i,:) = sortingIndices_u(1:20);
    entropy_concordance(i) = concordance(maxValueIndices_u(i,:),maxValueIndices_d(i,:));
end

for i = 1:10
    entropy_concordance_u(i) = concordance(maxValueIndices_u(i,:),maxValueIndices_u(i+1,:));
    entropy_concordance_d(i) = concordance(maxValueIndices_d(i,:),maxValueIndices_d(i+1,:));
end