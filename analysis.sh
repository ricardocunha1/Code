#!/bin/bash

UTILSPATH=Scripts/Utils
SESSIONFILE=sessionsFile.txt
QUERY_SCRIPTS_PATH=Scripts/QueryScripts
TERM_SCRIPTS_PATH=Scripts/TermScripts
SESSION_SCRIPTS_PATH=Scripts/SessionScripts

#query general stats (mean, std dev, etc.)
cat $SESSIONFILE | perl -X $UTILSPATH/extractQueries.pl | R --slave -f $QUERY_SCRIPTS_PATH/QueryGeneralStats.R

#country distribution
cat $SESSIONFILE | perl -X $UTILSPATH/extractCountry.pl | R --slave -f $QUERY_SCRIPTS_PATH/CountryDistribution.R

#city distribution

#hourly distribution
cat $SESSIONFILE | perl -X $UTILSPATH/ExtractDateAndQuery.pl | R --slave -f $QUERY_SCRIPTS_PATH/HourlyDistribution.R