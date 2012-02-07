ytdbugs2011 <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")
ytd2011png <- "/Users/tbarke000/TeamHealth/charts/bugs_ytd2011.png"

bugsopen <- read.table("/Users/tbarke000/TeamHealth/data/bugsopenbyiteration.txt", header=TRUE, sep=",")
bugsopenpng <- "/Users/tbarke000/TeamHealth/charts/bugs_remaining_open_by_release.png" 
bugsopencolumns = c("Fixed", "In Progress", "Open", "Pending", "Re-Opened")

weeklybugs <- read.table("/Users/tbarke000/TeamHealth/data/bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")
weeklybugspng <- "/Users/tbarke000/TeamHealth/charts/bugs_weekly_trend.png"

drawYTDBugs(ytdbugs2011, ytd2011png)
drawIterationBugsRemainingOpen(bugsopen, bugsopenpng, bugsopencolumns)
drawWeeklyBugTrend(weeklybugs , weeklybugspng)


drawYTDBugs <- function(ytdbugs, png){
#YTD Bugs
png(png)
	pct <- round(ytdbugs/sum(ytdbugs)*100) #convert to percentages
	slices <- c(pct$Resolved, pct$Unresolved) #pull out the values as vector so we can draw a pie
	lbls <- paste(colnames(pct), pct) # add percents to labels 
	lbls <- paste(lbls,"%",sep="") # ad % to labels
	pie(slices, labels =lbls, col=rainbow(length(colnames(pct))),main="YTD Bugs")
dev.off()	
}

drawIterationBugsRemainingOpen <- function(bugs, png, cols){
#Iteration Bugs Still Open
png(png, width = 480, height = 380, units = "px")
opar <- par(no.readonly=TRUE)
	par(mfrow=c(2,1))
	barplot(as.matrix(bugs), main="Bugs Remaining Open by Status ACDC", xlab="", ylab="", names.arg= cols)
	bugs <- t(bugs) #transpose the data to show stacked bar plot
	barplot(as.matrix(bugs), col=rainbow(length(rownames(bugs))), xlab="", ylab="", legend= cols)
par(opar)
dev.off()
}


drawWeeklyBugTrend <- function(bugs, png){
png(png)
	plot(bugs$Total, type="b", xlab="", ylab="", pch=15, lty=1, col="red", main="Bug Trend Report", axes=FALSE)
	axis(1, at=1: length(row.names(bugs)), lab= rownames(bugs))
	axis(2, las=1, at=10*0: range(bugs)[2])
dev.off()	
}
