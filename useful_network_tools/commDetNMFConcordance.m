% commDetNmf does not produce the communities in the same order each time
% This checks each combination between A and B
% Sets the highest concordance accordingly
% Inputs: A = group cell array
%         B = group cell array for next time period
% Ouputs: out = an array containing the concordance scores

function out = commDetNMFConcordance(A,B)

out = zeros(length(A),1);


for i = 1:length(A)
    C = 0;
    for j = 1:length(B)
        c = concordance(A{i},B{j});
        if c >= C
            C = c;
        end
    end
    out(i) = C;
end

end