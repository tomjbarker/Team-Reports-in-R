pds_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_pds.txt", header=TRUE, sep=",", row.names="developer")
xtv_commitsArchived <- read.table("/Users/tbarke000/TeamHealth/data/dev_commits_xtv.txt", header=TRUE, sep=",", row.names="developer")

pds_commitsacdc <- read.table("/Users/tbarke000/TeamHealth/data/commits_acdc_pds.txt", header=TRUE, sep=" ", row.names="developer")
xtv_commitsacdc <- read.table("/Users/tbarke000/TeamHealth/data/commits_acdc_xtv.txt", header=TRUE, sep=" ", row.names="developer")

pds_commitsbeatles <- read.table("/Users/tbarke000/TeamHealth/data/commits_beatles_pds.txt", header=TRUE, sep=" ", row.names="developer")
xtv_commitsbeatles <- read.table("/Users/tbarke000/TeamHealth/data/commits_beatles_xtv.txt", header=TRUE, sep=" ", row.names="developer")
cimspire_commitsbeatles <- read.table("/Users/tbarke000/TeamHealth/data/commits_beatles_cimspire.txt", header=TRUE, sep=" ", row.names="developer")

pdslines_beatles <- read.table("/Users/tbarke000/TeamHealth/data/linesofcode_beatles_pds.txt", header=TRUE, sep=" ", row.names="developer")
xtvlines_beatles <- read.table("/Users/tbarke000/TeamHealth/data/linesofcode_beatles_xtv.txt", header=TRUE, sep=" ", row.names="developer")
cimspirelines_beatles <- read.table("/Users/tbarke000/TeamHealth/data/linesofcode_beatles_cimspire.txt", header=TRUE, sep=" ", row.names="developer")

pdschartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitshistoric.png"
xtvchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitshistoric.png"
comparisonchartArchived <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonhistoric.png"

pdschartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitsacdc.png"
xtvchartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitsacdc.png"
comparisonchartacdc <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonacdc.png"


pdschartbeatles <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_pdshighlevelcommitsbeatles.png"
xtvchartbeatles <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_xtvhighlevelcommitsbeatles.png"
comparisonchartbeatles <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_avgcommitsizecomparisonbeatles.png"

linesofcodebeatles <- "/Users/tbarke000/TeamHealth/charts/TeamHealth_LinesofCode_Beatles.png"


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

png(linesofcodebeatles, width = 1080, height = 1080, units = "px")
	par(mfrow=c(2,2))
	drawDevLinesofCode(pdslines_beatles, "Beatles", "PDS")
	drawDevLinesofCode(xtvlines_beatles, "Beatles", "XTV")
	drawDevLinesofCode(cimspirelines_beatles, "Beatles", "CimSpire")
dev.off()


drawDevCommitCharts(pds_commitsArchived, xtv_commitsArchived, pdschartArchived, xtvchartArchived, comparisonchartArchived, "Historic")

drawDevCommitCharts(pds_commitsacdc, xtv_commitsacdc, pdschartacdc, xtvchartacdc, comparisonchartacdc, "AC/DC")
drawDevCommitCharts(pds_commitsbeatles, xtv_commitsbeatles, pdschartbeatles, xtvchartbeatles, comparisonchartbeatles, "Beatles")