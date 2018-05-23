

### This code is associated with the paper from Gerhard et al., "Conserved neural circuit structure across Drosophila larval development revealed by comparative connectomics". eLife, 2017. http://dx.doi.org/10.7554/eLife.29089



This repository contains data and analysis files for "Conserved neural circuit structure across Drosophila larval development revealed by comparative connectomics" by Gerhard et al. 2017.

The data covers the morphology and connectivity of sensory and interneurons for the nociceptive system of the Drosophila larva, both in first and third instars, reconstructed from electron microscopy.

JSON-formatted files for the morphology and connectivity of sensory and interneurons can be found in Morphology_Data_Files. Each file corresponds to an individual neuron. A separate readme in that directory contains the specific information about JSON formatting.

MATLAB data and analysis files are in Matlab_analysis. Three neuron data sets are in neuron_base_data.mat. Each data set is organized as a struct with indices for each neuron.
  neurons_noci: All nociceptive sensory neurons and targets from the first instar dataset (L1v). This includes ascending projection neurons, regional interneurons, etc.
  neurons_l1a_sp: Sensory neurons and local neurons from the L1v.
  neurons_l3_sp: Sensory neurons and local neurons from the L3v. Indexed the same as neurons_l1a_sp.

  Key properties of the struct for each neuron includes:
    xyz: the location of each skeleton node in nm.
    A: The adjacency matrix of skeleton nodes, defining the neuronal topology.
    Aw: The adjacency matrix between skeleton nodes, weighted by Euclidean distance (in nm).
    name: Neuron name, using the developmental lineage nomenclature followed in the original paper.
    soma: Index of the node (if any) corresponding to the neuron's cell body.
    microtubules_end: Index of nodes that split neurites with microtubules (i.e. backbone) from neurites  without microtubules (i.e. twigs).

  Analysis files associated with the Figures have been collected, along with necessary helper functions.

For any questions, contact me at
schneidermizellc@janelia.hhmi.org
-Casey Schneider-Mizell

All code is provided under the MIT License:

Copyright (c) 2017, Casey Schneider-Mizell
