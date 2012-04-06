currentSprint <- "doors"
printableSprintName <- "Doors"
dataDirectory <- "/Users/tbarke000/TeamHealth/data/"
chartDirectory <- "/Users/tbarke000/TeamHealth/charts/"
mbochartDirectory <- "/Users/tbarke000/TeamHealth/charts/mbo/"

wpologs <- read.table(paste(dataDirectory, "wpo_log.csv", sep=""), header=TRUE, sep=",")
wpochart <- paste(mbochartDirectory, "Performance_wpo_", currentSprint, ".pdf", sep="")


createDataFrameByURL <- function(wpologs, url){
df <- data.frame()
for (i in 1:nrow(wpologs)){
	if(wpologs$url[i] == url){
		df <- rbind(df , wpologs[i,])
	}
}
row.names(df) <- df$date
return(df)	
}

wpologs$bytes <- wpologs$bytes / 1000 #convert bytes to KB

xfnHP <- createDataFrameByURL(wpologs, "http://xfinity.comcast.net")
xfnHPTT <- createDataFrameByURL(wpologs, "http://xfinity.comcast.net/tt")
xtvHP <- createDataFrameByURL(wpologs, "http://xfinitytv.comcast.net/")
xfnProfile <- createDataFrameByURL(wpologs, "http://xfinity.comcast.net/profile/")
xfnLocal <- createDataFrameByURL(wpologs, "http://xfinity.comcast.net/local/19103/")
xtvTVL <- createDataFrameByURL(wpologs, "http://xfinitytv.comcast.net/tv-listings")
xtvVOD <- createDataFrameByURL(wpologs, "http://xfinitytv.comcast.net/ondemand")
xtvDVR <- createDataFrameByURL(wpologs, "http://xfinitytv.comcast.net/mytv/dvr")
xfnSports <- createDataFrameByURL(wpologs, "http://xfinity.comcast.net/sports/?cid=leftnav_sports")

WebSites <- c("XFN Homepage", "XFN TT Page", "XTV Homepage", "XFN Profile Page", "XFN Local Page", "XTV TV Listings", "XTV VOD", "XTV DVR", "XFN Sports")
WebSiteColors <- c("red", "blue", "green", "yellow", "orange", "purple", "pink", "brown", "#CCCCCC")

pdf(wpochart, height=12, width=12)
par(mfrow=c(2,2))
plot(xfnHP$loadtime, ylim=c(1000, 40000), type="l", xaxt="n", xlab="", col="red", ylab="Load Time in Milliseconds")
axis(1, at=1: length(row.names(xfnHP)), lab= rownames(xfnHP), cex.axis=0.3)
#axis(2, las=1, at=1: length(row.names(xfnHP)), lab = xfnHP$loadtime)
lines(xtvHP$loadtime, type="l", col="blue")
lines(xfnHPTT$loadtime, type="l", col="green")
lines(xfnProfile$loadtime, type="l", col="yellow")
lines(xfnLocal$loadtime, type="l", col="orange")
lines(xtvTVL$loadtime, type="l", col="purple")
lines(xtvVOD$loadtime, type="l", col="pink")
lines(xtvDVR$loadtime, type="l", col="brown")
lines(xfnSports$loadtime, type="l", col="#CCCCCC")

plot(xtvHP$bytes, ylim=c(500, 7462), type ="l", col="red", ylab="Page Size in KB", xlab="", xaxt="n")
axis(1, at=1: length(row.names(xfnHP)), lab= rownames(xfnHP), cex.axis=0.3)
lines(xfnHP$bytes, type="l", col="blue")
lines(xfnHPTT$bytes, type="l", col="green")
lines(xfnProfile$bytes, type="l", col="yellow")
lines(xfnLocal$bytes, type="l", col="orange")
lines(xtvTVL$bytes, type="l", col="purple")
lines(xtvVOD$bytes, type="l", col="pink")
lines(xtvDVR$bytes, type="l", col="brown")
lines(xfnSports$bytes, type="l", col="#CCCCCC")

plot(xtvHP$httprequests, ylim=c(10, 300), type ="l", col="red", ylab="HTTP Requests", xlab="", xaxt="n")	
axis(1, at=1: length(row.names(xfnHP)), lab= rownames(xfnHP), cex.axis=0.3)
lines(xfnHP$httprequests, type="l", col="blue")
lines(xfnHPTT$httprequests, type="l", col="green")
lines(xfnProfile$httprequests, type="l", col="yellow")
lines(xfnLocal$httprequests, type="l", col="orange")
lines(xtvTVL$httprequests, type="l", col="purple")
lines(xtvVOD$xtvVOD, type="l", col="pink")
lines(xtvDVR$httprequests, type="l", col="brown")
lines(xfnSports$httprequests, type="l", col="#CCCCCC")

plot(xtvHP$httprequests, type ="n", xlab="", ylab="", xaxt="n", yaxt="n", frame=FALSE)	
legend("topright", inset=.05, title="Legend", WebSites, lty=c(1), col= WebSiteColors)
dev.off()
