function H = get_entropy_from_soft_mem(P)

N = size(P,1);
H = zeros(1,size(P,1));

for n=1:N
    H(n) = get_entropy(P(n,:),'bits');
end