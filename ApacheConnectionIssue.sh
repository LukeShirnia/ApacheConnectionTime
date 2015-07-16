#!/bin/bash
 
###################################
 
neat="################################"
methodhttpd1=$( cat /etc/*release | grep -ic centos )
methodapache1=$( cat /etc/*release | grep -ic ubuntu )
 
##################################
#########CENTOS/RHL###############
apacherunning=$(service httpd status | grep -ic running)
apacheportcentos=$(netstat -plnt | grep http | awk '{print $4}' | sed 's/://g')
currentconcentos=$(ps afx | grep -ic /usr/sbin/httpd)
 
maxclientscentos=$(grep MaxClients /etc/httpd/conf/httpd.conf | grep processes -A 1 | awk '{print $2}' | grep -v MaxClients)
 
#####Error Log data#####
# SORT OUT REGEX FOR ERROR LOGS error.log / error_log
errorlogformat=$(grep ^ErrorLog /etc/httpd/conf/httpd.conf | awk '{print $2}' | sed 's/.*[/]//')
errorlogcentos=$( grep -ic maxc /var/log/httpd/$errorlogformat )
zerrorlogcentos=$( zgrep -i maxc /var/log/httpd/error_log* )
 
#####APACHE BUDDY DATA#####
apachebuddy=$(curl -s apache2buddy.pl | perl | grep -ohe 'Percentage of RAM allocated to Apache.*' | awk '{print $7}')
 
apachebuddyram=$(curl -s apache2buddy.pl | perl | grep -ohe 'Max potential memory usage:.*' | awk '{print $5}')
 
##################################
########Ubuntu/Debian#############
 
 
 
 
 
##################################
 
echo $neat
echo ""
##################################
method1() {
 
        case $apacherunning in
 
#------------------------
# apache not running!
        0 )
            echo "Not running"
            echo "Please troubleshoot further"
            echo ""
            echo $neat
# error logs?
#------------------------
#if apache is running then:
        ;;
        1 )
echo "Apache: is running!"
echo "Port: "$apacheportcentos
echo "Current Connections "$currentconcentos
echo "Configured Max Connections: "$maxclientscentos
#if there is a value configured in apache config file for MaxClients then calculate difference between current connections and configured connections
    if [ "$maxclientscentos" != "" ] && [ "$maxclientscentos" -ge 1 ];then
        maxcdiff=$(awk '{$maxclientscentos - $currentconcentos}')
        echo "Difference = "$maxcdiff
            if [ "$maxcdiff" -ge 1 ]; then
                echo "MaxClients: Not been reached"
            elif [ "$maxcdiff" = [1-9] ]; then
                echo "MaxClients: CLOSE TO LIMIT"
            else
                echo "MaxClients: LIMIT REACHED!"
            fi
# if no value has been added then
    else
        echo ""
        echo "MaxClients: No Configured Value In Apache Config File!!"
        echo "Checking with apache buddy..."
    fi
   
 #add awk for maxcdiff=$(awk '{$maxclientscentos - $currentconcentos}')
 
 
    if [ "$errorlogcentos" -ge 1 ]; then
# maxclients may have been hit a previous day, try to incoporate date in the search
        echo "Error logs:"
        echo $errorlogscentos
    else #elif
####APACHE BUDDY SECTION####    
        echo ""
        echo "Error Logs: Nothing to report!"
        echo "Current RAM allocation to apache: $apachebuddy%"
        echo "Apache Max RAM Usage: $apachebuddyram MB"
 
        case $apachebuddy in
        [0-75] )
            echo "apache has been allocated too much ram, this could be causing an issue"
        ;;
        *)
            echo "Apache Configuration: OK!"
        ;;
        esac
#############################
echo ""
echo $neat
#else
    fi
 
 
 
 
echo $neat
 
 
;;
        esac
}
 
 
#################################################
#Ubuntu
method2() {
 
 
 
echo "test"
 
 
 
 
}
 
 
 
 
 
 
 
 
 
 
 
##################################
if [ $methodhttpd1 -ge 1 ]; then
 
 
method1
 
 
##################################
#elif [ $methodapache1 -ge 1 ]; then
 
 
#method2
 
 
###################################
else
 
echo "Error! Server does not appear to be Ubuntu or Centos"
 
fi
###################################
#case $variable in
#
#apache )
#echo "Apache results: "
#echo "Maxclients = "
#echo "Recommended clients= "
#echo "Currently set clients= "
#echo "List of connected IPs= "
#;;
##################################
