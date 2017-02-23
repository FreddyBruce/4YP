function L = dissimilarity(A, Anull)
    [M,N] = size(A);
    L2dist = (A-Anull).^2;
    %L2dist = L2dist / var(reshape(A,M*N,1));
    %L = mean(mean(L2dist)); % normalised mean square error (NMSE)
    L = sum(sum(L2dist)) / sum(sum(L2dist>0));
    %L = (2/(n*(n-1)))*sum(sum((A-Anull).^2));
end
