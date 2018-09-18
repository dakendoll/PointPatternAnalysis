###PROJECTING AND FORMATTING DATA

#load required libraries
library(spatstat)
library(rgdal)
library(maptools)
library(raster)
library(sp)
library(plyr)

###ACQUIRE AND FORMAT DATA ###

#get data from here
#https://www.google.com/maps/d/viewer?mid=18u0QER64-OR_Kacg_EoKQpDUU5g&hl=en&ll=49.16837282831341%2C-122.63991487265628&z=10

#read in homicide events as shapefile, uses rgdal readOGR
km <- readOGR("path.kml")
#clean up the columns
km$Name <- as.character(km$Name)
#create a year column
km$year <- as.numeric(substr(km$Name, nchar(km$Name)-4, nchar(km$Name)))
#remove one observation without a year
km <- km[complete.cases(km$year),]

#project to bc albers
kma <- spTransform(km, CRS("+init=epsg:3005"))
#kma <- spTransform(km, CRS("+proj=aea +lat_1=50 +lat_2=58.5 +lat_0=45 +lon_0=-126 +x_0=1000000 
#                           +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"))

#add coordinates to the data
kma$x <- coordinates(kma)[,1]
kma$y <- coordinates(kma)[,2]

#check for and remove duplicated points
#check for duplicated points
#finds zero distance among points
zd <- zerodist(kma)
zd
#remove duplicates
kma <- remove.duplicates(kma)


#create an "extent" object which can be used to create the observation window for spatstat
kma.ext <- as.matrix(extent(kma)) 

#observation window
window <- as.owin(list(xrange = kma.ext[1,], yrange = kma.ext[2,]))

#create ppp oject from spatstat
kma.ppp <- ppp(x = kma$x, y = kma$y, window = window)
