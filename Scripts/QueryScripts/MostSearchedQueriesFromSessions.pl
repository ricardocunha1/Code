#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

%queries = ();

sub addQuery{
    $query = shift;
    if(exists($queries{$query})){
        $queries{$query}++;
    } else {
        $queries{$query} = 1;
    }
}

sub printResults {
    foreach $query ( sort{$queries{$a} <=> $queries{$b}} keys %queries){
        print "$query>>>$queries{$query}\n";
    }
}

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        my $keywords = lc($query[$keywordsIndex]);
        
        if($keywords ne ""){
            addQuery($keywords);
        }
    }
    
    printResults;
}

main;


