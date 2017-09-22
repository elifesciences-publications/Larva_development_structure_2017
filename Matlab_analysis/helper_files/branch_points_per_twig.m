function bps = branch_points_per_twig( neuron, twigs)

bps = zeros(size(twigs));
for ii = 1:length(twigs)
    Arel = sparse(size(neuron.Adir,1),size(neuron.Adir,2));
    Arel(twigs{ii},twigs{ii}) = neuron.Adir(twigs{ii},twigs{ii})>0;
    bps(ii) = sum( sum(Arel,1)>1 );
end
