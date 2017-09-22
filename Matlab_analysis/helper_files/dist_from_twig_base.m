function d_base = dist_from_twig_base( neuron, twigs )

d_base = zeros(length(twigs),1);

for ii = 1:length(twigs)
   relinds = [find(neuron.A(twigs{ii}(1),:)), twigs{ii}];
   Atwig = neuron.Aw(relinds,relinds);
   Ds_twig = shortest_paths(Atwig,1);
   d_base(ii) = max(Ds_twig(:));
end
