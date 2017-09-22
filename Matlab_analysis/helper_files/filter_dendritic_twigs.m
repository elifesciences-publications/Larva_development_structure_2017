function [twigs_dend, twigs_axon] = filter_dendritic_twigs( neuron, twigs )
% [twigs_dend, twigs_axon] = filter_dendritic_twigs( neuron, twigs )
% Returns cell arraye of twigs that are on axon/dendrite

is_dend_twig = true( size( twigs ) );
for ii = 1:length( twigs )
    if any( neuron.is_dendrite( twigs{ii} ) == 0 )
        is_dend_twig(ii) = false;
    end
end

twigs_dend = twigs( is_dend_twig );
twigs_axon = twigs( is_dend_twig==false );