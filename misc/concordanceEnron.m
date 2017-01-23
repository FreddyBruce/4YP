% Calculate the concordance for entire dataset
ave_conc = zeros(1,10);
for i = 1:12
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
axis([1 10 0 1]);