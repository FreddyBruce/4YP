function get_binding_energy_plot(W)
A = normc(W(:,any(W)));
imagesc(A);
colorbar
colormap(hot)
end