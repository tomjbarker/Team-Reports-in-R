cd /Users/tbarke000/Svnmetrics/xtv/trunk
svn up
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_xtv.log

cd /Users/tbarke000/Svnmetrics/portalds/trunk
svn up
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pds.log

cd /Users/tbarke000/Svnmetrics/cimspire/trunk
svn up
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_cimspire.log


cd /Users/tbarke000/Svnmetrics/hoss/hoss-webapp/trunk
svn up

cd /Users/tbarke000/Svnmetrics/pal/pal/trunk
svn up

cd /Users/tbarke000/Svnmetrics/xtvservices/
svn up

cd /Users/tbarke000/Svnmetrics/xtvservices/xtvservice/trunk
svn up

cd /Users/tbarke000/Svnmetrics/
mkdir doors
cd doors

mkdir xtv
cd xtv
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_xtv.log /Users/tbarke000/Svnmetrics/xtv/trunk/cTV
cd ..

mkdir pds
cd pds
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_pds.log /Users/tbarke000/Svnmetrics/portalds/trunk/
cd ..

mkdir cimspire
cd cimspire
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_cimspire.log /Users/tbarke000/Svnmetrics/cimspire/trunk/



