currentSprint <- "chicago"
printableSprintName <- "Chicago"
dataDirectory <- "/Users/tbarke000/TeamHealth/data/"
chartDirectory <- "/Users/tbarke000/TeamHealth/charts/"

pds_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_pds.txt", header=TRUE, sep=",", row.names="developer")
xtv_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_xtv.txt", header=TRUE, sep=",", row.names="developer")

pds_commits <- read.table(paste(dataDirectory, "commits_", currentSprint, "_pds.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
xtv_commits <- read.table(paste(dataDirectory, "commits_", currentSprint, "_xtv.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
cimspire_commits <- read.table(paste(dataDirectory, "commits_", currentSprint, "_cimspire.txt", sep=""), header=TRUE, sep=" ", row.names="developer")

pdslines <- read.table(paste(dataDirectory, "linesofcode_", currentSprint, "_pds.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
xtvlines <- read.table(paste(dataDirectory, "linesofcode_", currentSprint, "_xtv.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
cimspirelines <- read.table(paste(dataDirectory, "linesofcode_", currentSprint, "_cimspire.txt", sep=""), header=TRUE, sep=" ", row.names="developer")

cimspireLCLT <- read.table(paste(dataDirectory, "LoC_vs_LoT_", currentSprint, "_cimspire.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
xtvLCLT <- read.table(paste(dataDirectory, "LoC_vs_LoT_", currentSprint, "_xtv.txt", sep=""), header=TRUE, sep=" ", row.names="developer")
pdsLCLT <- read.table(paste(dataDirectory, "LoC_vs_LoT_", currentSprint, "_pds.txt", sep=""), header=TRUE, sep=" ", row.names="developer")


pdschartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitshistoric.png"
xtvchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitshistoric.png"
comparisonchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonhistoric.png"

pdschart <- paste(chartDirectory, "TeamHealth_pdshighlevelcommits", currentSprint, ".png", sep="")
xtvchart <- paste(chartDirectory, "TeamHealth_xtvhighlevelcommits", currentSprint, ".png", sep="")
comparisonchart <- paste(chartDirectory, "TeamHealth_avgcommitsizecomparison", currentSprint, ".png", sep="")

linesofcode <- paste(chartDirectory, "LinesofCode_", currentSprint, ".png", sep="")

pdsLCLTpng <- paste(chartDirectory, "LoCvsLoT_pds_", currentSprint, ".png", sep="")
xtvLCLTpng <- paste(chartDirectory, "LoCvsLoT_xtv_", currentSprint, ".png", sep="")
cimspireLCLTpng <- paste(chartDirectory, "LoCvsLoT_cimspire_", currentSprint, ".png", sep="")
LCLTpng <- paste(chartDirectory, "LoCvsLoT_", currentSprint, ".png", sep="")

drawLOCvsLOT <- function(data, codebase){
	data <- t(data)
	LCLTcolors <- c("red", "green")
	barplot(as.matrix(data), col=LCLTcolors, beside=TRUE, legend= row.names(data), cex.names=0.7, main=paste("Lines of Testable Code vs Lines of Test\n", codebase))
}


drawDevLinesofCode <- function(linesofcode, sprintname, codebase){
	radius <- sqrt(linesofcode$linesofcode/pi)
	symbols(linesofcode, circles=radius, bg="red", main=paste("Total Lines of Code for Sprint ", sprintname, "\n", codebase), xaxt="n", ylab="")
	text(linesofcode,row.names(linesofcode), cex=1, pos=4)
}

drawDevCommitCharts <- function(pds, xtv, pdschart, xtvchart, comparisonchart, sprintname){
	xtv <- xtv[order(row.names(xtv)),]
	pds <- pds[order(row.names(pds)),]
	
	#draw high level PDS charts
	png(pdschart, width = 680, height = 680, units = "px")
		opar <- par(no.readonly=TRUE)
		par(mfrow=c(2,1))
		symbols(pds$commits, bg="red", circles=sqrt(pds$commits/pi), main=paste("PDS Total Commits", sprintname),  xlab="", ylab="Number of Commits",xaxt="n")
		text(pds$commits, row.names(pds), cex=1, pos=4)
		#plot(pds$avglinesofcode, main=paste("PDS Avg Commit Size (in Lines of Code)", sprintname), xlab="", ylab="Lines of Code")
		symbols(pds$avglinesofcode, bg="red", circles= sqrt(pds$avglinesofcode/pi), main=paste("PDS Avg Commit Size (in Lines of Code)", sprintname), xaxt="n", ylab="Lines of Code")
		text(pds$avglinesofcode, row.names(pds), cex=1, pos=4)
		par(opar)
	dev.off()

	#draw high level XTV chart
	png(xtvchart, width = 680, height = 680, units = "px")
		opar <- par(no.readonly=TRUE)
		par(mfrow=c(2,1))
		symbols(xtv$commits, xaxt="n", bg="red", circles= sqrt(xtv$avglinesofcode/pi), main=paste("XTV Total Commits", sprintname),  xlab="", ylab="Number of Commits")
		text(xtv$commits, row.names(xtv), cex=1, pos=4)
		symbols(xtv$avglinesofcode, xaxt="n", bg="red", circles= sqrt(xtv$avglinesofcode/pi), main=paste("XTV Avg Commit Size (in Lines of Code)", sprintname), xlab="", ylab="Lines of Code")	
		text(xtv$avglinesofcode, row.names(xtv), cex=1, pos=4)
		par(opar)
	dev.off()


#draw comparison chart xtv vs pds avg number of lines changed per commit
	png(comparisonchart, width = 980, height = 980, units = "px")
		plot(xtv$avglinesofcode, type="b",
		pch=15, lty=1, col="red", ylim=c(0, 130), xlim=c(0, 25),
		main=paste("Avg Lines of Code Changed\n Per Commit for XTV and PDS", sprintname),
		xlab="", ylab="Avg Commit Size")
		text(xtv$avglinesofcode, row.names(xtv), cex=1, pos=4, col="red")
		lines(pds$avglinesofcode, type="b", pch=17, lty=2, col="blue")
		text(pds$avglinesofcode, row.names(xtv), cex=1, pos=4, col="blue")
		legend("topright", inset=.05, title="Legend", c("XTV","PDS"), lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))
	dev.off()
	
}

png(linesofcode, width = 1080, height = 1080, units = "px")
	par(mfrow=c(2,2))
	drawDevLinesofCode(pdslines, printableSprintName, "PDS")
	drawDevLinesofCode(xtvlines, printableSprintName, "XTV")
	drawDevLinesofCode(cimspirelines, printableSprintName, "CimSpire")
dev.off()


drawDevCommitCharts(pds_commitsArchived, xtv_commitsArchived, pdschartArchived, xtvchartArchived, comparisonchartArchived, "Historic")

drawDevCommitCharts(pds_commits, xtv_commits, pdschart, xtvchart, comparisonchart, printableSprintName)

png(LCLTpng, width = 1080, height = 1080, units = "px")
	par(mfrow=c(2,2))
	drawLOCvsLOT(pdsLCLT, "XFN")
	drawLOCvsLOT(xtvLCLT, "XTV")
	drawLOCvsLOT(cimspireLCLT, "CIMSpire")
dev.off()
