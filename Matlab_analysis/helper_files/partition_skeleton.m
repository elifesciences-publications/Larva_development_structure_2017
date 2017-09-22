function [P, dtr ] = partition_skeleton( Adir )
% [P, dtr ] = partition_skeleton( Adir )
% Partitions a directed, rooted tree with adjacency matrix Adir into a
% minimal set of towards-root paths fully covering the tree.
% P is a cell vector where each entry is the indices of a path, ordered distal to proximal.
% dtr is distance to root for a given node.

root = find( sum(Adir,2)==0);
leaves = find(sum(Adir,1)==0);

dtr = dist_to_root( Adir );

[~, ord] = sort( dtr( leaves ), 'descend' );
P = cell(length(ord),1);

seen = zeros(1,size(Adir,1));
seen(root)= 1;

for ii = 1:length( ord )
    curr_ind = leaves(ord(ii));
    P{ii}(end+1) = curr_ind;
    while seen( curr_ind )~=1
        parent_ind = find(Adir(curr_ind,:)>0);
        P{ii}(end+1) = parent_ind;
        seen(curr_ind) = 1;
        curr_ind = parent_ind;
    end    
end

total_length = zeros(size(P,1),1);
for ii = 1:length(P)
   total_length(ii) = dtr(P{ii}(1)) - dtr(P{ii}(end)); 
end

[~,part_ord] = sort( total_length, 'descend');
P = P(part_ord);