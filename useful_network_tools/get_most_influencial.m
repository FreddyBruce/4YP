% Finds the most influencial individual in the Network

function I = get_most_influencial(W)
[Y, I] = max(sum(W,2));
end