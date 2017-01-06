#!/bin/sh  
TOMCAT_HOME="/yuanben/tomcat80/bin"
pid=`ps aux |grep tomcat |grep -v grep |grep -v retomcat | awk '{print $2}'`  
echo $pid  
if [ -n "$pid" ]  
then  
{  
        echo =====kill tomcat ==========  
        kill -9 $pid  
        sleep 3  
        echo =========startup.sh =============  
       ${TOMCAT_HOME}/startup.sh  
}  
else  
echo ===========startup.sh=============  
	${TOMCAT_HOME}/startup.sh  
  
fi  