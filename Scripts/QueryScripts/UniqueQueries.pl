#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

use DB_File;
%queries = ();
tie(%queries, 'DB_File', "queries.dbfile", $DB_BTREE);

$numberQueries = 0;
$uniqueQueries = 0;

sub isQueryOnList{
    $query = shift;
    return exists($queries{$query});

}

sub processQuery{
    $keywords = shift;
    if(!isQueryOnList($keywords)){
        $queries{$keywords} = 1;
        $uniqueQueries++;
    } else {
        $queries{$keywords}++;
    }
}

sub printResults{
    print "unique>>>$uniqueQueries\n";
    print "total>>>$numberQueries\n";
    $ratio = sprintf("%.2f",($uniqueQueries/$numberQueries)*100);
    print "ratio>>>$ratio%\n";
    
    my $counter=0;
    my $top1000queries=0;
    foreach $query ( sort{$queries{$b} <=> $queries{$a}} keys %queries){
        if($counter==1000){
            last;
        }
        
        $top1000queries += $queries{$query};
        $counter++;
    }
    print "top1000>>>" . ($top1000queries/$numberQueries)*100;
    
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
untie(%queries);


