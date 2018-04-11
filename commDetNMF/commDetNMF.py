def commDetNMF(V,max_rank,W0,H0):
    """Implements the community detection methodlogy presented in
    'Overlapping Community Detection Nonegative Matrix Factorization'
    by Ioannis Psorakis, Stephen Roberts, Mark Ebden and Ben Sheldonself.

    Inputs :
    V: NxN adjacency matrix
    max_rank: a prior estimation on the maximum number of communities (optional)
    W0,H0: prior values fo W, H factors (optional)
    Outputs :
    P: NxK matrix where each element Pik represents the (normalised) soft
    membership score of node-i to each community-k. P captures the OVERLAPPING
    community structureself.
    g: groups cell array. Each element g{k} contains the node indices of
    community k. Each node i is placed in the community g{k} for which it has
    the maximum Pnk. Therefore g describes the NON-OVERLAPPING community
    structureself.

    W,H are the NMF factors (normalised from 0 to 1)

    NOTES:
    -----
    - In many cases the algorithm gives better results is the diagonals of
    adjancency matric are non-zero, for example Aii = degree(i)
    - having an estimation on the upper bound of the community numbers
    "max_rank" will significantly increase the performance of the algorithm
    - P is based on W with zero columns removed
    - Due to the coordinate descend optimisation scheme (see "Automatic
    Relevance Determination in Nonnegative Factorization", SPARS '09 by Tan
    and Fevotte) the NMF result is initilisation dependent. You may have to
    run the algorithm multiple times if you didn't get the desired result from
    the first time.
    """



def nmfBayesMap(V,n_iter,W,H):
    """[W, H, outStruct] = nmfBayesMap(V,n_iter,W,H,b0)
    performs MAP Bayesian inference for W,H such that V ~ W*H
    
