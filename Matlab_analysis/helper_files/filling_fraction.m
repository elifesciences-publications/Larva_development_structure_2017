function [ff, nfill, nprox] = filling_fraction( pre_neuron, post_neuron, del, min_strahler )

if nargin < 5
   min_strahler = 1; 
end

sn = strahler_number( post_neuron );
post_xyz = post_neuron.xyz(sn>=min_strahler,:);

pre_xyz = pre_neuron.synsout.xyz;

D = min( dist(post_xyz,pre_xyz), [], 1 );
Du = D < (del * 1000);

nprox = sum( Du );
nfill = length(intersect( post_neuron.synsin.connind, pre_neuron.synsout.connind( Du ) ) );
ff = nfill/nprox;