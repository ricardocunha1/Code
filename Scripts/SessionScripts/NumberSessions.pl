#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
$sessionCounter=0;
$currentSession=0;
sub main {
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        
        if($query[$sessionIdIndex] != $currentSession){
            $currentSession = $query[$sessionIdIndex];
            $sessionCounter++;
        }
    }
    
    print "Number sessions: $sessionCounter\n";
}

main;


