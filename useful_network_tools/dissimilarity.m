function L = dissimilarity(A, Anull)
    n = size(A,1);
    
    L = (-1/(n*(n-1)))*sum(sum((A-Anull).^2));
end
