###KERNEL DENSITY ESTIMATION
#2D (gaussian) kernel, compare how bandwidth (sigma) selection influences the point density estimates
#since data are projected, sigma is represented in metres
#eps is the width and height of the pixels (1000m X 1000m)
#coerce to a SpatialGridDataFrame for plotting
kde.100 <- density(kma.ppp, sigma = 100, at = "pixels", eps = c(1000, 1000))
kde.SG <- as(kde.100, "SpatialGridDataFrame")
kde.500 <- density(kma.ppp, sigma = 500, at = "pixels", eps = c(1000, 1000))
kde.SG <- cbind(kde.SG, as(kde.500, "SpatialGridDataFrame"))
kde.1k <- density(kma.ppp, sigma = 1000, at = "pixels", eps = c(1000, 1000)) 
kde.SG <- cbind(kde.SG, as(kde.1k, "SpatialGridDataFrame"))
kde.5k <- density(kma.ppp, sigma = 5000, at = "pixels", eps = c(1000, 1000))
kde.SG <- cbind(kde.SG, as(kde.5k, "SpatialGridDataFrame"))

names(kde.SG) <- c("kde.100m", "kde.500m", "kde.1km", "kde.5km")
#plot
x11() #opens a new plot window
spplot(kde.SG)

#can see how the bandwidth selection influences the density estimates
summary(kde.SG)

#use cross-validation to get the bandwidth that minimizes MSE
bw.d <- bw.diggle(kma.ppp)
#plot the "optimal" bandwidth
plot(bw.d, ylim=c(-10, 10), main="Cross validation for murder events")

#density using the cross-validation bandwidth
kde.bwo <- density(kma.ppp, sigma = bw.d, at = "pixels", eps = c(1000, 1000))
plot(kde.bwo)
