library(portfolio)

currentSprint <- "doors"
printableSprintName <- "Doors"
dataDirectory <- "/Users/tbarke000/TeamHealth/data/"
mbochartDirectory <- "/Users/tbarke000/TeamHealth/charts/mbo/"

commitvsaccept <- read.table(paste(dataDirectory, "commitvsaccept_", currentSprint, ".txt", sep=""), header=TRUE, sep=",", row.names="Team")
iterationdata <- read.table(paste(dataDirectory, "storypoint_allocation_", currentSprint, ".csv", sep=""), header=TRUE, sep=",")

commitvsacceptpng <- paste(mbochartDirectory, "Delivery_CommitvsAccept_", currentSprint, ".png", sep="")
pointsbyteam <- paste(mbochartDirectory, "Delivery_PointsbyTeams_", currentSprint, ".png", sep="")
topstoriesoverallpng <- paste(mbochartDirectory, "Delivery_TopStories_", currentSprint, "_Overall.png", sep="")
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
pointsbyproduct <- head(pointsbyproduct[order(pointsbyproduct,decreasing=T),],.09*nrow(pointsbyproduct))
png(chart, width = 680, height = 680, units = "px")
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
png(chart, width = 680, height = 680, units = "px")
	opar <- par(no.readonly=TRUE)
	par(las=1, mar=c(10,10,10,10))	
	barplot(storypointbyproject, horiz=TRUE, col="yellow", main = paste("Total Story Points by Team for ", printableSprintName, sep=""))
	par(opar)
dev.off()	
}


drawCommitvsAccept <- function(data, sprint, chart){
png(chart, width = 680, height = 680, units = "px")
	iterationColors <- c("#FF6666", "#00CC66")
	data <- t(data)
	barplot(as.matrix(data), beside=TRUE,legend= row.names(data), cex.names=0.6, main=paste("Story Points\n Commited Vs Accepted\n", sprint), col= iterationColors)
dev.off()
}


#drawCommitvsAccept(commitvsaccept ,printableSprintName, commitvsacceptpng)
drawPointsByTeam(iterationdata, pointsbyteam)
drawTopStories(iterationdata, topstoriesoverallpng)
drawTreemapofEpics(epictreemap)