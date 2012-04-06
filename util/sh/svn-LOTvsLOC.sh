#!/bin/sh

repoDirectory = "/Users/tbarke000/Svnmetrics"


cd /Users/tbarke000/Svnmetrics/hoss/hoss-webapp/trunk/src/test
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_hoss_test.log

cd /Users/tbarke000/Svnmetrics/hoss/hoss-webapp/trunk/src/main
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_hoss_testablecode.log

cd /Users/tbarke000/Svnmetrics/pal/pal/trunk/src/test
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pal_test.log

cd /Users/tbarke000/Svnmetrics/pal/pal/trunk/src/main
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pal_testablecode.log

cd /Users/tbarke000/Svnmetrics/pal/pal/trunk/src/main
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pal_testablecode.log

cd Users/tbarke000/Svnmetrics/xtvservices/xtvservice/trunk/src/test
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_xtvservices_test.log

cd /Users/tbarke000/Svnmetrics/xtvservices/xtvservice/trunk/src/main
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_xtvservices_testablecode.log

cd /Users/tbarke000/Svnmetrics/xtv/trunk/cTV/src/main/webapp/js
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_xtv_testablecode.log

cd /Users/tbarke000/Svnmetrics/portalds/trunk/src/test
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pds_test.log

cd /Users/tbarke000/Svnmetrics/portalds/trunk/src/main/webapp/layout/js
svn log -v --xml -r {2012-03-12}:{2012-03-31} > /Users/tbarke000/TeamHealth/logs/doors_pds_testablecode.log

cd /Users/tbarke000/Svnmetrics/cimspire/trunk/src/test
svn log -v --xml -r {2012-02-27}:{2012-03-11} > /Users/tbarke000/TeamHealth/logs/doors_cimspire_test.log

cd /Users/tbarke000/Svnmetrics/cimspire/trunk/src/main/webapp/cimspire/js
svn log -v --xml -r {2012-02-27}:{2012-03-11} > /Users/tbarke000/TeamHealth/logs/doors_cimspire_testablecode.log

cd /Users/tbarke000/Svnmetrics/doors
mkdir hoss_linesoftest
cd hoss_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_hoss_test.log /Users/tbarke000/Svnmetrics/hoss/hoss-webapp/trunk/src/test

cd /Users/tbarke000/Svnmetrics/doors
mkdir hoss_linesofcode
cd hoss_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_hoss_testablecode.log /Users/tbarke000/Svnmetrics/hoss/hoss-webapp/trunk/src/main

cd /Users/tbarke000/Svnmetrics/doors
mkdir pal_linesoftest
cd pal_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_pal_test.log /Users/tbarke000/Svnmetrics/pal/pal/trunk/src/test

cd /Users/tbarke000/Svnmetrics/doors
mkdir pal_linesofcode
cd pal_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_pal_testablecode.log /Users/tbarke000/Svnmetrics/pal/pal/trunk/src/main

cd /Users/tbarke000/Svnmetrics/doors
mkdir xtvservices_linesoftest
cd xtvservices_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_xtvservices_test.log /Users/tbarke000/Svnmetrics/xtvservices/xtvservice/trunk/src/test

cd /Users/tbarke000/Svnmetrics/doors
mkdir xtvservices_linesofcode
cd xtvservices_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_xtvservices_testablecode.log /Users/tbarke000/Svnmetrics/xtvservices/xtvservice/trunk/src/main


cd /Users/tbarke000/Svnmetrics/doors
mkdir xtv_linesoftest
cd xtv_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_xtv_test.log /Users/tbarke000/Svnmetrics/xtv/trunk/cTV/src/test/

cd /Users/tbarke000/Svnmetrics/doors
mkdir xtv_linesofcode
cd xtv_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_xtv_testablecode.log /Users/tbarke000/Svnmetrics/xtv/trunk/cTV/src/main/webapp/js/

cd /Users/tbarke000/Svnmetrics/doors
mkdir pds_linesoftest
cd pds_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_pds_test.log /Users/tbarke000/Svnmetrics/portalds/trunk/src/test/

cd /Users/tbarke000/Svnmetrics/doors
mkdir pds_linesofcode
cd pds_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_pds_testablecode.log /Users/tbarke000/Svnmetrics/portalds/trunk/src/main/webapp/layout/js


cd /Users/tbarke000/Svnmetrics/doors
mkdir cimspire_linesoftest
cd cimspire_linesoftest
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_cimspire_test.log /Users/tbarke000/Svnmetrics/cimspire/trunk/src/test/

cd /Users/tbarke000/Svnmetrics/doors
mkdir cimspire_linesofcode
cd cimspire_linesofcode
java -jar /Users/tbarke000/Desktop/statsvn/statsvn.jar /Users/tbarke000/TeamHealth/logs/doors_cimspire_testablecode.log /Users/tbarke000/Svnmetrics/cimspire/trunk/src/main/webapp/cimspire/js/

