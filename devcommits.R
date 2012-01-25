pds_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_pds.txt", header=TRUE, sep=",", row.names="developer")
xtv_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_xtv.txt", header=TRUE, sep=",", row.names="developer")

pds_commitsacdc <- read.table("/Users/tbarke000/TeamHealth/data/commits_acdc_pds.txt", header=TRUE, sep=" ", row.names="developer")
xtv_commitsacdc <- read.table("/Users/tbarke000/TeamHealth/data/commits_acdc_xtv.txt", header=TRUE, sep=" ", row.names="developer")

pdschartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitshistoric.png"
xtvchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitshistoric.png"
comparisonchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonhistoric.png"

pdschartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitsacdc.png"
xtvchartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitsacdc.png"
comparisonchartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonacdc.png"



drawDevCommitCharts <- function(pds, xtv, pdschart, xtvchart, comparisonchart){
	xtv <- xtv[order(row.names(xtv)),]
	pds <- pds[order(row.names(pds)),]
	
	#draw high level PDS charts
	png(pdschart, width = 680, height = 680, units = "px")
		opar <- par(no.readonly=TRUE)
		par(mfrow=c(2,1))
		plot(pds$commits, main="PDS Total Commits",  xlab="", ylab="Number of Commits")
		text(pds$commits, row.names(pds), cex=1, pos=4)
		plot(pds$avglinesofcode, main="PDS Avg Commit Size (in Lines of Code)", xlab="", ylab="Lines of Code")	
		text(pds$avglinesofcode, row.names(pds), cex=1, pos=4)
		par(opar)
	dev.off()

	#draw high level XTV chart
	png(xtvchart, width = 680, height = 680, units = "px")
		opar <- par(no.readonly=TRUE)
		par(mfrow=c(2,1))
		plot(xtv$commits, main="XTV Total Commits",  xlab="", ylab="Number of Commits")
		text(xtv$commits, row.names(xtv), cex=1, pos=4)
		plot(xtv$avglinesofcode, main="XTV Avg Commit Size (in Lines of Code)", xlab="", ylab="Lines of Code")	
		text(xtv$avglinesofcode, row.names(xtv), cex=1, pos=4)
		par(opar)
	dev.off()


#draw comparison chart xtv vs pds avg number of lines changed per commit
	png(comparisonchart, width = 980, height = 980, units = "px")
		plot(xtv$avglinesofcode, type="b",
		pch=15, lty=1, col="red", ylim=c(0, 130), xlim=c(0, 25),
		main="Avg Lines of Code Changed\n Per Commit for XTV and PDS",
		xlab="", ylab="Avg Commit Size")
		text(xtv$avglinesofcode, row.names(xtv), cex=1, pos=4, col="red")
		lines(pds$avglinesofcode, type="b", pch=17, lty=2, col="blue")
		text(pds$avglinesofcode, row.names(xtv), cex=1, pos=4, col="blue")
		legend("topright", inset=.05, title="Legend", c("XTV","PDS"), lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))
	dev.off()
	
}

drawDevCommitCharts(pds_commitsArchived, xtv_commitsArchived, pdschartArchived, xtvchartArchived, comparisonchartArchived)

drawDevCommitCharts(pds_commitsacdc, xtv_commitsacdc, pdschartacdc, xtvchartacdc, comparisonchartacdc)