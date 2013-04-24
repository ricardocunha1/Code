#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

@queriesPerSession = (0) x 10;

sub addNQueriesToArray{
    $nQueries = shift;
    if($nQueries >= 10){
        $queriesPerSession[9]++;
    } else {
        $queriesPerSession[$nQueries-1]++;
    }
}

sub main{
    $currentSession = 1;
    $nQueries = 0;
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        if($query[$sessionIdIndex] != $currentSession){
            addNQueriesToArray($nQueries);
            $currentSession = $query[$sessionIdIndex];
            $nQueries = 1;
        } else {
            $nQueries++;
        }
    }
    
    $i=0;
    while($i < scalar(@queriesPerSession)){
        print "$i>>>$queriesPerSession[$i]\n";
        $i++;
    }
}

main;


