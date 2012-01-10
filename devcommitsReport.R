pds_commits <- read.table("dev_commits_pds.txt", header=TRUE, sep=",", row.names="developer")
xtv_commits <- read.table("dev_commits_xtv.txt", header=TRUE, sep=",", row.names="developer")

#draw high level PDS chart
png("TeamHealth_pdshighlevelcommits.png")
	plot(pds_commits)
	title(main = "PDS Commits 2010-2011", xlab="x-axis label", ylab="y-axis label")
dev.off()

#draw high level XTV chart
png("TeamHealth_xtvhighlevelcommits.png")
	plot(xtv_commits)
	title(main = "XTV Commits 2010-2011", xlab="x-axis label", ylab="y-axis label")
dev.off()


#draw comparison chart xtv vs pds avg number of lines changed per commit
png("TeamHealth_avgcommitsizecomparison.png")
	plot(xtv_commits$avglinesofcode, type="b",	pch=15, lty=1, col="red", ylim=c(0, 60),	main="Avg Lines of Code Changed per Commit for XTV and PDS",	xlab="X", ylab="Y")
	lines(pds_commits$avglinesofcode, type="b", pch=17, lty=2, col="blue")
dev.off()
