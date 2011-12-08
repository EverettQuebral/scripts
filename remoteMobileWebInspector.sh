#!/bin/sh
#
# author : Everett P. Quebral
# license : MIT License

# this script will let you remotely debug your page in Mobile Safari in iOS Simulator
# works only for Mac with iOS Simulator version 5.0 >

# 1.  Start iOS Simulator, and visit the site
# 2.  Execute the script and it will open up Safari with the Web Developer tools

if [ "$1" == "" ]; then
	#####
	# find the process for the Mobile Safari
	#####
	MS_PID=$(ps x | grep "MobileSafari" | grep -v grep | awk '{ print $1 }')

	if [ "$MS_PID" == "" ]; then
	  # Mobile Safari not found - then exit
	  echo "Please start iOS Simulator with Mobile Safari opened the page you want to debug"
	  exit 1;
	else
	  # inject the code to the Mobile Safari process
	  cat <<EOM | gdb
	  attach $MS_PID
	  p (void *)[WebView _enableRemoteInspector]
	  detach
EOM

	fi

else
	echo "Finding Process ID for $1"
	MS_PID=$(ps x | grep $1 | grep -v grep | awk 'NR==1{ print $1 }')
	echo $MS_PID
fi

#####
# get the remoting url and open up safari in developer tools
#####
RemotingURL=$(lsof -i TCP -a -p $MS_PID -P | awk 'NR==2{print $9}')

echo Opening Developer Console $RemotingURL

open "http://$RemotingURL"