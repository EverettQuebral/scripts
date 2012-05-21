#!/bin/sh
#
# author : Everett P. Quebral
# license : MIT License
# 
# environment variables needed to be set
# TARGET_APP_NAME	: the source directory location
# APP_NAME			: the name of the app deployed
# WEBAPP_DIR 		: the webapp directory to deploy = /usr/local/tomcat5
# MAVEN_DIR			: maven directory to use

# reset everything before deploying
# stop tomcat
echo "Shutting down tomcat"
$WEBAPP_DIR/bin/catalina.sh stop -force
wait

# remove the link
echo "rm -fr $WEBAPP_DIR/webapps/$APP_NAME"
rm -fr $WEBAPP_DIR/webapps/$APP_NAME

# you need to be on the app directory to run it
# compile install
$MAVEN_DIR/mvn clean install 

# create a link to the WEBAPP_DIR
ln -s $PWD/target/$TARGET_APP_NAME $WEBAPP_DIR/webapps/$APP_NAME

# start tomcat
#$WEBAPP_DIR/bin/shutdown.sh
$WEBAPP_DIR/bin/catalina.sh start

#wait
#open http://localhost:8080/$APP_NAME




