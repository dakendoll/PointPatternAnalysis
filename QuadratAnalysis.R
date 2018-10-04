###QUADRAT ANALYSIS

##First, determine the number of qusdrats 
quads <- 10

qcount = quadratcount(kma.ppp, nx = quads, ny = quads)

plot(kma.ppp, pch = "+", cex = 0.5)
plot(qcount, add = T, col = "red")

qcount.df <- as.data.frame(qcount)

##Second, count the number of quadrats with a distinct number of points.
qcount.df = plyr::count(qcount.df,'Freq')
##Change the column names so that x=number of points and f=frequency of quadrats with x cells.
colnames(qcount.df) = c("x","f")

##Third, create new columns for total number of points and for fx^2.
qcount.df$TotPoints <- qcount.df$x * qcount.df$f
qcount.df$fx2 = (qcount.df$x)^2 * qcount.df$f
qcount.df$xfx2 = qcount.df$fx2 * qcount.df$f #adjusted for the count 

##Fourth, calculate the sum of each column, which you will use as inputs into the 
##formula for VMR.
f.sum = sum(qcount.df$f)
TotPoints.sum = sum(qcount.df$TotPoints) 
fx2.sum = sum(qcount.df$fx2) 


##Fifth, calculate VAR, MEAN, and VMR. ### OF WHICH VARIABLES? f.sum, TotPoints.Sum, fx2.sum?
m = sum(qcount.df$f)
VAR = sum(qcount.df$xfx2)/(m-1)
mean.points = TotPoints.sum/(m) # n/m
VMR = VAR/mean.points

##Finally, perform the test statistic to test for the existence of a random spatial pattern.
chi.square = VMR*(m-1)
p = 1 - pchisq(chi.square,nrow(qcount.df))
#The P-Value is < 0.00001. The result is significant at p < 0.05
