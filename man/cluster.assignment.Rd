% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/celltype.R
\name{cluster.assignment}
\alias{cluster.assignment}
\title{Partition cells into disjoint clusters}
\usage{
cluster.assignment(object, feature.type = "gene", rds.dims = 1:3,
  update.cellgroup = T, clustering.method = "hc", verbose = T, ...)
}
\arguments{
\item{object}{A sincera object}

\item{feature.type}{The feature space used for clustering: "gene" - means gene expression space, "pca" - means reduced dimension space using PCA}

\item{rds.dims}{A numberic vector specified the reduced dimensions used for clustering. Only take effect when the feature.type is "pca" or "tsne"}

\item{update.cellgroup}{The clustering result will be saved to the "CLUSTER" meta data. If TRUE, the GROUP meta data will be updated as well.}

\item{clustering.method}{The cluster identification algorithm, possible values include pam, kmeans, hc, graph, tight, consensus}

\item{verbose}{If TRUE, print the verbose messages}
}
\value{
The update sincera object with clustering results in the "CLUSTER" meta data, use getCellMeata with name="CLUSTER" to assess the result
}
\description{
Partition cells into disjoint clusters
}
\details{
The default clustering method is hc - hierarchical clustering with Pearson's correlation based distance and average linkage. 
Possible parameters include:
  h - if not NULL, cut dendrogram tree at the height h;
  k - if not NULL, cut dendrogram tree to generate k clusters; if both k and h are not NULL, k will be used; If both k and h are NULL, the algorithm will find the largest k that contains no more than num.singleton singleton clusters; 
  num.singleton - the number of singleton clusters allowed;
  distance.method - the method to calculate cell distance, possible values include pearson, spearman, euclidean;
  linkage.method - linkage method, possible values include average, complete, ward.D2;
  do.shift - if TRUE, shit column mean to 0.

     
When clustering.method is graph, the function utilizes the graph based method described in Shekhar et al., 2016, which first constructs a kNN graph of cells and then applies a community detection algorithm to partition cells.
Possible parameters include:
  num.nn - The number of nearest neighbors considered during the kNN graph construction; 
  do.jaccard - If TRUE, weigh kNN graph edges using Jaccard similarity;
  community.method - The community detection method, possible values include louvain, infomap, walktrap, spinglass, edge_betweenness, label_prop, optimal, fast_greedy.
   
   
When clustering.method is tight, the function utilizes tightClust::tight.clust() to perform tight clustering. Note that this algorithm may produce a partial partition of cells. Cells will be assigned with "-1" membership if they are not assigned to any found tight clusters. please refer to ?tightClust::tight.clust for more informaiton.


When clustering.method is consensus, the function utilizes ConsensusClusterPlus::ConsensusClusterPlus() to perform consensus clustering; the parameter "min.area.increase" is a threshold value for determining the number of clusters; let k be the current choice of the number of clusters, if the delta area from k-1 to k is greater than min.area.increase, k will be increased by 1 until the delta area increase is below min.area.increase or k=maxK. The calculation of delta area is defined in the original paper of ConsensusClusterPlus (Wilkerson et al., Bioinformatics 2010). Please refer to ?ConsensusClusterPlus::ConsensusClusterPlus for the setting of other parameters.


When clustering.method is kmeans, the function utilizes stats::kmeans() to perform k-means clustering; please refer to ?kmeans for parameters and more informaiton.


When clustering.method is pam, the function utilizes cluster::pam() to perform Partitioning Around Medoids clustering; please refer to ?cluster::pam for parameters and more information.
}
