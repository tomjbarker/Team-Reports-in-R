#YTD Bugs
png("BugsYTD.png")
	ytdbugs <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")
	pct <- round(ytdbugs/sum(ytdbugs)*100) #convert to percentages
	slices <- c(pct$Resolved, pct$Unresolved) #pull out the values as vector so we can draw a pie
	lbls <- paste(colnames(pct), pct) # add percents to labels 
	lbls <- paste(lbls,"%",sep="") # ad % to labels
	pie(slices, labels =lbls, col=rainbow(length(colnames(pct))),main="YTD Bugs")
dev.off()

#Iteration Bugs Still Open
bugsopen <- read.table("bugsopenbyiteration.txt", header=TRUE, sep=",")
bugsopencolumns = c("Fixed", "In Progress", "Open", "Pending", "Re-Opened")
png("BugsRemainingOpen.png", width = 680, height = 680, units = "px")
opar <- par(no.readonly=TRUE)
	par(mfrow=c(2,1))
	barplot(as.matrix(bugsopen), main="Bugs Remaining Open by Status ACDC", xlab="", ylab="", names.arg= bugsopencolumns)
	bugsopen <- t(bugsopen) #transpose the data to show stacked bar plot
	barplot(as.matrix(bugsopen), col=rainbow(length(rownames(bugsopen))), xlab="", names.arg=c(""), ylab="", legend= bugsopencolumns)
par(opar)
dev.off()

#Trend by date
#TODO abstract to a function and call for each year
weeklybugs <- read.table("bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")
png("BugsWeekly.png")
	plot(weeklybugs$Total, type="b", xlab="", ylab="", pch=15, lty=1, col="red", main="Bug Trend Report", axes=FALSE)
	axis(1, at=1: length(row.names(weeklybugs)), lab= rownames(weeklybugs))
	axis(2, las=1, at=10*0: range(weeklybugs)[2])
dev.off()