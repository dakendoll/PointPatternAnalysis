###NEAREST NEIGHBOUR
nearestNeighbour <- nndist(kma.ppp)
##Convert the nearestNeighbor object into a dataframe.
nearestNeighbour=as.data.frame(as.numeric(nearestNeighbour))
##Change the column name to "Distance"
colnames(nearestNeighbour) = "Distance"


##Calculate the nearest neighbor statistic to test for a random spatial distribution.
#mean nearest neighbour
nnd = sum(nearestNeighbour$Distance)/nrow(nearestNeighbour)

#mean nearest neighbour for random spatial distribution
r.nnd = 
  
d.nnd = 

r = 

z = 



