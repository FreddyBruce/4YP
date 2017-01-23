function H = get_entropy(p,base)
if ~exist('base','var')
    base = 'nats';
end

p = p./sum(p);

h = -1*safe_log(p,base);
H = sum(p.*h,2);
end