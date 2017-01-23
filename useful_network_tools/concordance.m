% calculates the concordance between two input communities
function c = concordance(A, B)
lia = ismember(A,B);
c = sum(lia)/length(lia);
end