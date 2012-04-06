library(portfolio)

currentSprint <- "doors"
printableSprintName <- "Doors"
dataDirectory <- "/Users/tbarke000/TeamHealth/data/"
mbochartDirectory <- "/Users/tbarke000/TeamHealth/charts/mbo/"

commitvsaccept <- read.table(paste(dataDirectory, "commitvsaccept_", currentSprint, ".txt", sep=""), header=TRUE, sep=",", row.names="Team")
iterationdata <- read.table(paste(dataDirectory, "storypoint_allocation_", currentSprint, ".csv", sep=""), header=TRUE, sep=",")

commitvsacceptpng <- paste(mbochartDirectory, "Delivery_CommitvsAccept_", currentSprint, ".pdf", sep="")
pointsbyteam <- paste(mbochartDirectory, "Delivery_PointsbyTeams_", currentSprint, ".pdf", sep="")
topstoriesoverallpng <- paste(mbochartDirectory, "Delivery_TopStories_", currentSprint, "_Overall.pdf", sep="")
epictreemap <- paste(mbochartDirectory, "Delivery_EpicTreemap_", currentSprint, ".pdf", sep="")

pointsbyproduct <- rowsum(iterationdata$Plan.Estimate, iterationdata$Name, na.rm=TRUE)
colnames(pointsbyproduct) <- c("TotalPoints")

summary(iterationdata$Plan.Estimate)
sum(iterationdata$Plan.Estimate, na.rm=TRUE)


drawTreemapofEpics <- function(chart){
#treemap needs there to be no commas in any field, no NAs, and no empty estimates
epiclist <- as.matrix(iterationdata[2])
epictotalpoints <- c()

for (i in 1:nrow(iterationdata)){
	epic <- epiclist[i]
	#print(epic)
	for(j in 1:length(rownames(pointsbyproduct))){
		if(length(epic) > 0){
			if (rownames(pointsbyproduct)[j] == epic){
				epictotalpoints <- c(epictotalpoints ,pointsbyproduct[j])
			} 			
		}
	}
}
iterationdata$epictotal <- epictotalpoints
#remove 0 estimate stories
iterationdata <-iterationdata[!(iterationdata$Plan.Estimate == 0),]
#remove nas
iterationdata <- na.omit(iterationdata)
pdf(chart)
	map.market(id= iterationdata$Project, area= iterationdata$epictotal, group= iterationdata$Name, color= iterationdata$epictotal, main=paste("Overview of Stories\n", printableSprintName), lab=c(TRUE, TRUE))
dev.off()
}

drawTopStories <- function(data, chart){
pointsbyproduct <- rowsum(data$Plan.Estimate, data$Name, na.rm=TRUE)
colnames(pointsbyproduct) <- c("TotalPoints")
pointsbyproduct <- head(pointsbyproduct[order(pointsbyproduct,decreasing=T),],1*nrow(pointsbyproduct))
pdf(chart, width = 12, height = 12)
	pointsbyproduct <- t(pointsbyproduct)
	opar <- par(no.readonly=TRUE)
		par(las=1, mar=c(10,10,10,10))	
		barplot(pointsbyproduct, horiz=TRUE, cex.names=0.7, main = paste("Top 10% of all Stories in ", printableSprintName, sep=""))
		par(opar)
dev.off()

}

drawPointsByTeam <- function(data, chart){
storypointbyproject <- rowsum(data$Plan.Estimate, data$Project, na.rm = TRUE)
colnames(storypointbyproject) <- c("TotalPoints")
storypointbyproject <- storypointbyproject[order(storypointbyproject),]
pdf(chart, width = 10, height = 10)
	opar <- par(no.readonly=TRUE)
	par(las=1, mar=c(10,10,10,10))	
	barplot(storypointbyproject, horiz=TRUE, col="yellow", main = paste("Total Story Points by Team for ", printableSprintName, sep=""))
	par(opar)
dev.off()	
}


drawCommitvsAccept <- function(data, sprint, chart){
pdf(chart, width = 8, height = 8)
	iterationColors <- c("#00CC66", "#FF6666")
	opar <- par(no.readonly=TRUE)
	par(las=1, mar=c(10,10,10,10))	
	data <- data[order(data$Committed,decreasing=T),]
	data$Difference <- data$Committed - data$Accepted
	xcom <- data.frame()
	xcom <- rbind(data$Accepted, data$Difference)
	row.names(xcom) <- c("Accepted", "Not Accepted")
	colnames(xcom) <- row.names(data)
	barplot(as.matrix(xcom), horiz=TRUE, col=iterationColors)
	par(opar)
dev.off()
}


drawCommitvsAccept(commitvsaccept ,printableSprintName, commitvsacceptpng)
drawPointsByTeam(iterationdata, pointsbyteam)
drawTopStories(iterationdata, topstoriesoverallpng)
drawTreemapofEpics(epictreemap)