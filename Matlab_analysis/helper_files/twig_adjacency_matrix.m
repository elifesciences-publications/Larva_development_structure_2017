function A_twig = twig_adjacency_matrix( neurons, twigs )

A_twig = zeros(length(neurons));

for ii = 1:length(neurons)
    for kk = 1:length( twigs{ii} )
        [~,inds_on_twig] = intersect( neurons(ii).synsin.treeinds, twigs{ii}{kk});
        inputs_on_twig = setdiff(unique( neurons(ii).synsin.origind(inds_on_twig)), -1);
        A_twig(ii,inputs_on_twig) = A_twig(ii,inputs_on_twig)+1;
    end
end
