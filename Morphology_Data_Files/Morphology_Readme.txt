Neuron morphology and synaptic connectivity data accompanying "Conserved neural circuit structure across Drosophila larval development revealed by comparative connectomics" are in Morphology_Data_Files.

Neurons were reconstructed in CATMAID as skeletons and synaptic connections. Each json file includes the structure and synapse information of a single neuron. Files are named for the data set (either 'L1v' for the first instar data or 'L3v' for the third instar data) and the unique neuron id.

The json structure is organized as follows:

"neuron": {
  "name"     : Neuron name, indicating cell type and location (a1 indicates segment a1, l/r indicates left/right)
  "id"       : Neuron id
  "nodes"    : Each row describes a neurite skeleton node
              [node id, x location (nm), y location (nm), z location (nm), Boolean value indicating if the node is dendritic]
  "topology" : List of directed connections between nodes.
              [child node id, parent node id]
  "syns_in"  : Each row describes a synaptic input.
              [connector id, x location (nm), y location (nm), z location (nm), associated skeleton node id]
  "syns_out" : Each row describes a synaptic output site.
              [connector id, x location (nm), y location (nm), z location (nm), associated skeleton node id,  number of postsynaptic targets]
  "soma"     : Node id of the neuron's soma, if present. Otherwise, values are null.
  "twig_base": List of node ids where twigs start, i.d. the first location on a branch without microtubules.
}
