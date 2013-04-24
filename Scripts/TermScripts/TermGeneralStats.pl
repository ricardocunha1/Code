#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%termsHash = ();

sub isTermOnHash{
    my $term = shift;
    return exists($termsHash{$term});
}

sub addQueryTerms{
    my $query = shift;
    my @terms = split(/\s/,$query);
    
    foreach $term (@terms){
        #test for empty terms
        if($term ne ""){
            if(isTermOnHash($term)){
                $termsHash{$term}++;
            } else {
                $termsHash{$term} = 1;
            }
        }
    }
}

sub printResults{
    foreach $term ( sort{$termsHash{$b} <=> $termsHash{$a}} keys %termsHash){
        print "$term>>>$termsHash{$term}\n";
    }
}

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        
        addQueryTerms(lc($query[$keywordsIndex]));
    }
    
    printResults;
}

main;


