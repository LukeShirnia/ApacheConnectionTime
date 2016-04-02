# ApacheConnectionTimeAlert
This script has been designed for use diagnosing apache issues such as:
- time-outs
- localhost timeouts
- websites not loading
- slow loading speeds

The script gathers the following information:
- Running Webservers and respective ports
- Current web server processes
- Recommended values
- Current RAM allocation based on current settings
- Any potential warnings
- Summary of error logs
- Current established connections to web server

Working Distrbutions:
- CentOS 5 / 6 /7


###---Perfomance and tweaks coming soon ---###

To run the script:  
bash <(curl -s https://raw.githubusercontent.com/luke7858/ApacheConnectionTime/master/ApacheConnectionIssue.sh )
