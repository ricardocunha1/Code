#!/bin/bash

LOGSPATH=../Logs/

find LOGSPATH | grep ".gz$" | xargs gzcat | perl -X Scripts/FilterScripts/extractMobileQueries.pl

cat mobileDataSet.txt | perl -X Scripts/FilterScripts/createSessionsFile.pl