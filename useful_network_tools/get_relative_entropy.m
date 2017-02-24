function H = get_relative_entropy(P)

comm_num = size(P,2);

H_o = ones(1,size(P,1)).*safe_log(comm_num, 'bits');
H_wh = get_entropy_from_soft_mem(P);
H = H_o - H_wh;
end