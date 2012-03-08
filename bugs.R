ytdbugs <- read.table("/Users/tbarke000/TeamHealth/data/bugsytd.txt", header=TRUE, sep=",", row.names="Year")
ytdpng <- "/Users/tbarke000/TeamHealth/charts/bugs_ytd.png"
bugsopen <- read.table("/Users/tbarke000/TeamHealth/data/bugsopenbyiteration.txt", header=TRUE, sep=",")
bugsopenpng <- "/Users/tbarke000/TeamHealth/charts/bugs_remaining_open_by_release.png" 
bugsopencolumns = c("Fixed", "In Progress", "Open", "Pending", "Re-Opened")

weeklybugs <- read.table("/Users/tbarke000/TeamHealth/data/bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")
weeklybugspng <- "/Users/tbarke000/TeamHealth/charts/bugs_weekly_trend.png"

iterationbugs <- read.table("/Users/tbarke000/TeamHealth/data/bugstotalbyiteration.txt",  header=TRUE, sep=",", row.names="Iteration")
iterationbugspng <- "/Users/tbarke000/TeamHealth/charts/bugs_total_by_iteration.png"

featvsregress <- read.table("/Users/tbarke000/TeamHealth/data/bugfeaturevsregression.txt", header=TRUE, sep=",")
featvsregresspng <- "/Users/tbarke000/TeamHealth/charts/bugs_ featvsregress.png"

bugsbymodule <- read.table("/Users/tbarke000/TeamHealth/data/bugsbymodule.txt", header=TRUE, sep=",")
bugsbymodulepng <- "/Users/tbarke000/TeamHealth/charts/bugs_ totalbymodule.png"

drawIterationBugsRemainingOpen(bugsopen, bugsopenpng, bugsopencolumns, "Beatles")
drawWeeklyBugTrend(weeklybugs , weeklybugspng)
drawTotalBugsByIteration(iterationbugs, iterationbugspng)
drawYTDBugs(ytdbugs, ytdpng)
drawFeatureVSRegression(featvsregress, featvsregresspng)
drawBugsByModule(bugsbymodule, bugsbymodulepng)

drawBugsByModule<- function(data,png){
	data <- data[order(data$Bugs),]
	bugcolor <- vector()
	for(i in 1:length(data$Bugs)){
		if(data$Bugs[i] > 5)
			bugcolor <- c(bugcolor, "red")
		else{
			bugcolor <- c(bugcolor, "orange")		
			}
	}
	png(png, width = 780, height = 880, units = "px")
	opar <- par(no.readonly=TRUE)
	par(las=1, mar=c(10,10,10,10))		
	barplot(data$Bugs, xlab="Number of Bugs", names.arg=data$Module, horiz=TRUE, space=1, cex.axis=0.6, cex.names=0.8, main="Open Bugs by Module", col= bugcolor)
	par(opar)
	dev.off()

}

drawFeatureVSRegression<- function(data, png){
	bugcolors <- c("#05FF22","#F00505")
	pcts <- 100 * (data/sum(data))
	pcts<-t(pcts)
	png(png)
	barplot(as.matrix(pcts), col=bugcolors, main="Percentage of Bugs Feature vs Regression", legend=rownames(pcts))
	dev.off()
}

drawYTDBugs <- function(ytdbugs, png){	
#YTD Bugs
png(png)
	ytdbugs <- t(ytdbugs)
	bugcolors <- c("#05FF22","#F00505")
	year <- ytdbugs[1:2]
	pcts <- 100 * (year/sum(year))
	pcts <- data.frame(pcts, row.names = c("Resolved", "Unresolved")) #, "Pending"))
	nextyear <- ytdbugs[4:5]
	nextpct <- data.frame(100 * (nextyear/sum(nextyear)), row.names=c("Resolved", "Unresolved" ))  #, "Pending"))
	pct <- cbind(pcts, nextpct)
	colnames(pct) <- c("2011", "2012")
	lbls <- paste(cbind(year,nextyear))
	barplot(as.matrix(pct), col= bugcolors,main="Percent of Bugs Closed by Year")
	#text(x=c(1,length(pct)), y=as.matrix(round(pct)), labels= lbls, cex=.8, col="#FFFFFF")
dev.off()	
}

drawIterationBugsRemainingOpen <- function(bugs, png, cols, iteration){
#Iteration Bugs Still Open
png(png, width = 480, height = 380, units = "px")
opar <- par(no.readonly=TRUE)
	par(mfrow=c(2,1))
	barplot(as.matrix(bugs), main=paste("Bugs Remaining Open by Status ", iteration), xlab="", ylab="", names.arg= cols)
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
