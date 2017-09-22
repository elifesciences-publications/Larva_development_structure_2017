function N = count_subset_instances( base_set, whitelist )
% N = count_subset_instances( base_set, whitelist ) where
% base_set is your list of numbers and whitelist is the list of numbers
% (without repeats) that you want to count within the base set.
N = 0;
for ii = 1:length(whitelist)
   N = N + sum( base_set == whitelist(ii) ); 
end