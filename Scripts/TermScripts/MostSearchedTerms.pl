#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

use DB_File;
%terms = ();
tie(%terms, 'DB_File', "terms.dbfile", $DB_BTREE);

$numberTerms=0;

sub addTerms{
    $query = shift;
    @termsArray = split(/\s/, $query);
    foreach $term (@termsArray){
        if($term ne ""){
            if(exists($terms{$term})){
                $terms{$term}++;
            } else {
                $terms{$term} = 1;
            }
            $numberTerms++;
        }
    }
}

sub printResults {
    print "$numberTerms\n";
    $counter = 0;
    foreach $term ( sort{$terms{$b} <=> $terms{$a}} keys %terms){
        if($counter == 500){
            last;
        }
        print "$term>>>$terms{$term}\n";
        $counter++;
    }
}

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        my $keywords = lc($query[$keywordsIndex]);
        
        if($keywords ne ""){
            addTerms($keywords);
            
        }
    }
    
    printResults;
}

main;
untie(%terms);

