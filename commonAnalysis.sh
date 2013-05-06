#!/bin/bash

#variables
UTILSPATH=Scripts/Utils
QUERY_SCRIPTS_PATH=Scripts/QueryScripts
TERM_SCRIPTS_PATH=Scripts/TermScripts
SESSION_SCRIPTS_PATH=Scripts/SessionScripts

MOBILE_SESSION_PATH=MobileDataset/sessionFile.txt
DESKTOP_SESSION_PATH=PCDataset/sessionFile.txt


##########################
###QUERY LEVEL ANALYSIS###
##########################

#mobile and pc common hourly distribution
cat $MOBILE_SESSION_PATH $DESKTOP_SESSION_PATH | perl -x $UTILSPATH/ExtractHourAndQuery.pl | R --slave -f $QUERY_SCRIPTS_PATH/MobilePCHourlyDistribution.R


#mobile and pc common weekly distribution
cat $MOBILE_SESSION_PATH $DESKTOP_SESSION_PATH | perl -x $UTILSPATH/ExtractDateAndQuery.pl | R --slave -f $QUERY_SCRIPTS_PATH/MobilePCWeeklyDistribution.R

############################
###SESSION LEVEL ANALYSIS###
############################

###########################
####TERM LEVEL ANALYSIS####
###########################
