ytdbugs2011 <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")
ytd2011png <- "/Users/tbarke000/TeamHealth/charts/bugs_ytd2011.png"

bugsopen <- read.table("/Users/tbarke000/TeamHealth/data/bugsopenbyiteration.txt", header=TRUE, sep=",")
bugsopenpng <- "/Users/tbarke000/TeamHealth/charts/bugs_remaining_open_by_release.png" 
bugsopencolumns = c("Fixed", "In Progress", "Open", "Pending", "Re-Opened")

weeklybugs <- read.table("/Users/tbarke000/TeamHealth/data/bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")
weeklybugspng <- "/Users/tbarke000/TeamHealth/charts/bugs_weekly_trend.png"


iterationbugs <- read.table("/Users/tbarke000/TeamHealth/data/bugstotalbyiteration.txt",  header=TRUE, sep=",", row.names="Iteration")
iterationbugspng <- "/Users/tbarke000/TeamHealth/charts/bugs_total_by_iteration.png"



drawYTDBugs(ytdbugs2011, ytd2011png)
drawIterationBugsRemainingOpen(bugsopen, bugsopenpng, bugsopencolumns)
drawWeeklyBugTrend(weeklybugs , weeklybugspng)
drawTotalBugsByIteration(iterationbugs, iterationbugspng)


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


drawTotalBugsByIteration <- function(bugs,png){
bugs <- t(bugs)
bugcolors <- c("#05FF22", "#FFFF05" ,"#F00505")
png(png, width = 480, height = 580, units = "px")
	barplot(bugs, col= bugcolors, legend=rownames(bugs), ylim=c(0,150), ylab="Bugs", xlab="Iteration")
	
	text(x=c(1,length(iterationbugs$Resolved)), y=5, labels= iterationbugs$Resolved, cex=.8, col="#FFFFFF") #Annotate resolved bugs

	pendingYs <- vector()
	for(i in 1:length(iterationbugs$Pending)){(pendingYs<- c(pendingYs, sum(iterationbugs$Resolved[i], iterationbugs$Pending[i])-1))}
	text(x=c(1,length(iterationbugs$Pending)), y= pendingYs, labels= iterationbugs$Pending, cex=.8, col="#FFFFFF") #Annotate pending bugs
	
	unresolvedYs <-vector()
	for(i in 1:length(iterationbugs$Unresolved)){(unresolvedYs <- c(unresolvedYs, sum(iterationbugs$Resolved[i], iterationbugs$Pending[i], iterationbugs$Unresolved[i]) - 2))}
	text(x=c(1,length(iterationbugs$Unresolved)), y= unresolvedYs, labels= iterationbugs$Unresolved, cex=.8, col="#FFFFFF")#Annotate unresolved bugs
dev.off()
}
