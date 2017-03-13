#!/bin/bash
# chkconfig: 2345 10 90
# description: Starts and Stops the Tomcat daemon.
TOMCAT_HOME=/yuanben/tomcat_7.0.70/dubbo_8080
TOMCAT_START=$TOMCAT_HOME/bin/startup.sh
TOMCAT_STOP=$TOMCAT_HOME/bin/shutdown.sh
# necessary environment variables export
CATALINA_HOME=$TOMCAT_HOME
export JAVA_HOME=/usr/java/jre1.6.0_10
# source function library.
. /etc/rc.d/init.d/functions
if [ ! -f $TOMCAT_HOME/bin/catalina.sh ]
then echo "Tomcat not valilable..."
	exit
fi
start(){
	echo -n "Starting Tomcat: "
	daemon $TOMCAT_START
	echo
	touch /var/lock/subsys/tomcat
}
stop(){
	echo -n {1}quot;Shutting down Tomcat: "
	daemon $TOMCAT_STOP
	rm -f /var/lock/subsys/tomcat.pid echo
}
restart(){
	stop
	start
}
status(){
	ps ax --width=1000 | grep "[o]rg.apache.catalina.startup.Bootstrap start" | awk '{printf $1 " "}' | wc | awk '{print $2}' > /tmp/tomcat_process_count.txt
	read line < /tmp/tomcat_process_count.txt
	if [ $line -gt 0 ]; then
		echo -n "tomcat ( pid "
		ps ax --width=1000 | grep "org.apache.catalina.startup.Bootstrap start" | awk '{printf $1 " "}'
		echo -n ") is running..."
		echo
	else
		echo "Tomcat is stopped"
	fi
}
case "$1" in
start)
start ;;
stop)
stop ;;
restart)
stop
sleep 3
start ;;
status)
status ;;
*)
echo "Usage: tomcatd {start|stop|restart|status}"
exit 1
esac
exit
