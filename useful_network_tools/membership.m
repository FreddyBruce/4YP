% Membership function tracks an individuals concordance score
% Finds the community of the node for the input time steps and then
% calculates the concordance score.
% Inputs: node = individual to be tracked
%         A = groups cell array
%         B = groups cell array for next time period
% Outputs C = concordance score


function C = membership(node, A, B)
    
    for i = 1:length(A)
        n = ~isempty(find(A{i} == node, 1));
        if n == 1
            for j = 1:length(B)
                m = ~isempty(find(B{j} == node, 1));
                if m == 1
                   C = concordance(A{i},B{j});
                end
            end
        end
    end
end
    