%% Load data
% Get path to a subfolder off the current working directory
filePattern = fullfile(pwd, 'Data/enronmail/update');
addpath(filePattern);
filePattern2 = fullfile(pwd, 'useful_network_tools');
addpath(filePattern2);


emails = importdata('emails.csv', ' ');
dates = importdata('dates.csv',',');

%% Randomize, augment and export to csv

for i = 1:3
    emails_random = emails(randperm(length(emails)));
    output = [emails_random, dates];
    cell2csv(sprintf('random_emails_%d.csv',i), output, ',');
end