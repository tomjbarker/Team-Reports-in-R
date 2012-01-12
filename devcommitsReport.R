pds_commits <- read.table("dev_commits_pds.txt", header=TRUE, sep=",", row.names="developer")
xtv_commits <- read.table("dev_commits_xtv.txt", header=TRUE, sep=",", row.names="developer")
ytdbugs <- read.table("2011cumulativebugs.txt", header=TRUE, sep=",")

#xtv_commits$developer <- factor(xtv_commits$developer, order=TRUE)

#draw high level PDS charts
png("TeamHealth_pdshighlevelcommits.png")
	opar <- par(no.readonly=TRUE)	par(mfrow=c(2,1))
	plot(pds_commits$commits, main="PDS Total Commits",  xlab="", ylab="Number of Commits")
	plot(pds_commits$avglinesofcode, main="PDS Avg Commit Size (in Lines of Code)", xlab="", ylab="Lines of Code")	
	#text(pds_commits$avglinesofcode, row.names(pds_commits), cex=0.6, pos=4)
	par(opar)
dev.off()

#draw high level XTV chart
png("TeamHealth_xtvhighlevelcommits.png")
	opar <- par(no.readonly=TRUE)
	par(mfrow=c(2,1))
	plot(xtv_commits$commits, main="XTV Total Commits",  xlab="", ylab="Number of Commits")
	plot(xtv_commits$avglinesofcode, main="XTV Avg Commit Size (in Lines of Code)", xlab="", ylab="Lines of Code")	
	#text(xtv_commits$avglinesofcode, row.names(xtv_commits), cex=0.6, pos=4)
	par(opar)
dev.off()


#draw comparison chart xtv vs pds avg number of lines changed per commit
png("TeamHealth_avgcommitsizecomparison.png")
	plot(xtv_commits$avglinesofcode, xtv_commits$developer, type="b",	pch=15, lty=1, col="red", ylim=c(0, 60),	main="Avg Lines of Code Changed\n Per Commit for XTV and PDS",	xlab="", ylab="Avg Commit Size")
	text(xtv_commits$avglinesofcode, row.names(xtv_commits), cex=0.6, pos=4, col="red")
	lines(pds_commits$avglinesofcode, type="b", pch=17, lty=2, col="blue")
	text(pds_commits$avglinesofcode, row.names(pds_commits), cex=0.6, pos=4, col="blue")
	legend("topright", inset=.05, title="Legend", c("XTV","PDS"), lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))
dev.off()
