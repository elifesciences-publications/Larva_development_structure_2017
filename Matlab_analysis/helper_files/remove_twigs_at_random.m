function syn_left = remove_twigs_at_random( syns_in_conn, p_remove, ntimes)
% syn_left = remove_twigs_at_random( syns_in_conn, p_remove, ntimes)
%   syns_in_conn: N_twig x 1 vector of number of syns in a particular
%   connection.
%   p_remove: scalar for probability of missing a twig
%   ntimes: number of trials to run

if size(syns_in_conn, 1) < size(syns_in_conn, 2)
    syns_in_conn = syns_in_conn';
end

syn_mat = repmat( syns_in_conn, 1, ntimes);
syn_left_mat = zeros(size(syn_mat));

p_rand = rand(length( syns_in_conn ), ntimes);
syn_left_mat(p_rand>=p_remove) = syn_mat(p_rand>=p_remove);

syn_left = sum( syn_left_mat, 1 );