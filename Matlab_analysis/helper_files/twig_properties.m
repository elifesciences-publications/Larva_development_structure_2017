function [tw_syns, tw_lens, tw_bps, tw_dpt] = twig_properties(neuron, twigs)

tw_syns = zeros(size(twigs));
for ii =1:length(twigs)
   tw_syns(ii) = count_subset_instances( twigs{ii}, neuron.synsin.treeinds );
end

tw_lens = zeros(size(twigs));

for ii =1:length(twigs)
   relinds = union(twigs{ii},find(neuron.A(twigs{ii}(1),:)) );
   tw_lens(ii) = sum(sum(neuron.Aw(relinds,relinds)))/2;
end

tw_dpt = dist_from_twig_base( neuron, twigs );

tw_bps = branch_points_per_twig( neuron, twigs);