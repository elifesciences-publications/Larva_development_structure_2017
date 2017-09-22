function syns_in_conn = synapses_in_connection_per_twig( neuron, twigs, presyn_ind )
%syns_in_conn = synapses_in_connection_per_twig( neurons, twigs, presyn_inds )

syns_in_conn = zeros( size( twigs ) );
nodes_for_presyn = neuron.synsin.treeinds( neuron.synsin.origind == presyn_ind );

for ii = 1:length(twigs)
    syns_in_conn( ii ) = numel( intersect( nodes_for_presyn, twigs{ii} ) );
end