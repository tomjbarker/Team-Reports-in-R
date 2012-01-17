library(plotrix)

ytdbugs <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",", row.names="Year")

#convert to percentages
pct <- round(ytdbugs/sum(ytdbugs)*100)
#pull out the values as vector so we can draw a pie
slices <- c(pct$Resolved, pct$Unresolved)
lbls <- paste(colnames(pct), pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels
pie(slices, labels =lbls, col=rainbow(length(colnames(pct))),main="YTD Bugs")

#fan.plot(slices, labels = colnames(pct), main="Fan Plot")
text(slices, row.names(pct), cex=0.6, pos=4, col="blue")


#colnames(pct)