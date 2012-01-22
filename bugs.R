ytdbugs <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")
weeklybugs <- read.table("bugsbydate.txt", header=TRUE, sep=" ", row.names="Date")

#YTD Bugs
pct <- round(ytdbugs/sum(ytdbugs)*100) #convert to percentages
slices <- c(pct$Resolved, pct$Unresolved) #pull out the values as vector so we can draw a pie
lbls <- paste(colnames(pct), pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels

pie(slices, labels =lbls, col=rainbow(length(colnames(pct))),main="YTD Bugs")



#Trend by date
#for(row in grep("2012", rownames(weeklybugs))){
#	2012bugs <- weeklybugs[row]
#}

plot(weeklybugs$Total, type="b", pch=15, lty=1, col="red", main="Bug Trend Report",)