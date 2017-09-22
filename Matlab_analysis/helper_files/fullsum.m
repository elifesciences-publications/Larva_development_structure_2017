function s = fullsum( M )
% Sum of all elements in an arbitary shaped matrix.
Ms = reshape( M, numel(M), 1);
s = sum(Ms);