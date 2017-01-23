function lp = safe_log(x,base)
if ~exist('base','var')
    base = 'bits';
end

if strcmp(base,'bits')
    lp = log2(x);
elseif strcmp(base,'nats')
    lp = log(x);
end

infs = isinf(lp);
lp(infs) = 0;
end