#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

use DB_File;
%queries = ();
tie(%queries, 'DB_File', "queries.dbfile", $DB_BTREE);

$numberQueries=0;

sub addQuery{
    $query = shift;
    if(exists($queries{$query})){
        $queries{$query}++;
    } else {
        $queries{$query} = 1;
    }
}

sub printResults {
    print "$numberQueries\n";
    $counter = 0;
    foreach $query ( sort{$queries{$b} <=> $queries{$a}} keys %queries){
        if($counter == 500){
            last;
        }
        print "$query>>>$queries{$query}\n";
        $counter++;
    }
}

sub main{
    while($_ = <STDIN>){
        if($_ ne "\n"){
            @query = split(/>>>/, $_);
            $keywords = lc($query[$keywordsIndex]);
            
            if($keywords ne ""){
                addQuery($keywords);
                $numberQueries++;
            }
        }
    }
    
    printResults;
}

main;
untie(%queries);


