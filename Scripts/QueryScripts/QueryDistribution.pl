#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
use DB_File;
%uniqueQueries = ();
tie(%uniqueQueries, 'DB_File', "unique.dbfile", $DB_BTREE);
$totalQueries = 0;

sub addUniqueQueries{
    my $query = shift;
    if(exists($uniqueQueries{$query})){
        $uniqueQueries{$query}++;
    } else {
        $uniqueQueries{$query} = 1;
    }
    
}

sub printResults {
    my $numberUnique = scalar(keys %uniqueQueries);
    print "$totalQueries>>>$numberUnique\n";
    foreach $query (sort{$uniqueQueries{$b} <=> $uniqueQueries{$a}} keys %uniqueQueries){
        print "$query>>>$uniqueQueries{$query}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        $keywords = lc($query[$keywordsIndex]);
        addUniqueQueries($keywords);
        $totalQueries++;
        
    }
    
    printResults();
}

main;
untie(%uniqueQueries);


