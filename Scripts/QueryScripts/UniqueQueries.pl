#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

@queries = ();
$numberQueries = 0;
$uniqueQueries = 0;

sub isQueryOnList{
    $keywords = shift;
    foreach $query (@queries){
        if($query eq $keywords){
            return 1;
        }
    }
}

sub processQuery{
    $keywords = shift;
    if(!isQueryOnList($keywords)){
        push(@queries, $keywords);
        $uniqueQueries++;
    }
}

sub printResults{
    print "Unique queries: $uniqueQueries\n";
    print "Total queries: $numberQueries\n";
    $ratio = sprintf("%.2f",($uniqueQueries/$numberQueries)*100);
    print "Ratio: $ratio%\n"
}

sub main{
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        $keywords = $query[$keywordsIndex];
        
        processQuery($keywords);
        $numberQueries++;
    }
    
    printResults();
}

main;


