% coverts adj matrix to adj list
L = adj2adjL(O01D);
% finds strongly connected components
[GSCC,v] = tarjan(L);