#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/TermScripts' }
require "FunctionWords.pl";
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%queries = ();


sub addQueryHash {
    my $length = shift;
    if(exists($queries{$length})){
        $queries{$length}++;
    } else {
        $queries{$length} = 1;
    }
    
}

sub processQuery {
    my $query = shift;
    my $queryLength = length($query);
    
    addQueryHash($queryLength);
    
}

sub printResults {
    foreach $charLength (sort{ $a <=> $b} keys %queries){
        print "$charLength>>>$queries{$charLength}\n";
    }
    
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        $keywords = lc($query[$keywordsIndex]);
        if($keywords ne ""){
            processQuery($keywords);
        }
     
    }
    
    printResults();
}

main;





