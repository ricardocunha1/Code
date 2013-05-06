#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        if($query[$countryIndex] =~  "KW"){
            print "$_";   
        }
    }
}

main;


