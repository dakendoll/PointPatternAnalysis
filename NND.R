###NEAREST NEIGHBOUR
nearestNeighbour <- nndist(kma.ppp)
##Convert the nearestNeighbor object into a dataframe.
nearestNeighbour=as.data.frame(as.numeric(nearestNeighbour))
##Change the column name to "Distance"
colnames(nearestNeighbour) = "Distance"

n = as.numeric(nrow(nearestNeighbour))
##Calculate the nearest neighbor statistic to test for a random spatial distribution.
#mean nearest neighbour
nnd = (sum(nearestNeighbour$Distance)/n)/1000

#FVRD 13361.74 + GVRD 2882.68 OR convex hull area 7953.76
#density
density = n/7953.76

#mean nearest neighbour for random spatial distribution
r.nnd = 1/(2*sqrt(density))
  
d.nnd = 1.07453/(sqrt(density))

r = nnd/r.nnd

sig.nnd = (0.26136)/(sqrt(n*density))

z = (nnd-r.nnd)/sig.nnd
