ytdbugs <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")
weeklybugs <- read.table("bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")


#YTD Bugs
pct <- round(ytdbugs/sum(ytdbugs)*100) #convert to percentages
slices <- c(pct$Resolved, pct$Unresolved) #pull out the values as vector so we can draw a pie
lbls <- paste(colnames(pct), pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels

pie(slices, labels =lbls, col=rainbow(length(colnames(pct))),main="YTD Bugs")

#Iteration Bugs Still Open
bugsopen <- read.table("bugsopenbyiteration.txt", header=TRUE, sep=",")
bugsopencolumns = c("Fixed", "In Progress", "Open", "Pending", "Re-Opened")
opar <- par(no.readonly=TRUE)
	par(mfrow=c(2,1))
	barplot(as.matrix(bugsopen), main="Bugs Remaining Open by Status", xlab="", ylab="", names.arg= bugsopencolumns)
	bugsopen <- t(bugsopen) #transpose the data to show stacked bar plot
	barplot(as.matrix(bugsopen), col=rainbow(length(rownames(bugsopen))), xlab="", names.arg=c(""), ylab="", legend= bugsopencolumns)
par(opar)

#Trend by date
#for(row in grep("2012", rownames(weeklybugs))){
#	2012bugs <- weeklybugs[row]
#}

plot(weeklybugs$Total, type="b", pch=15, lty=1, col="red", main="Bug Trend Report")