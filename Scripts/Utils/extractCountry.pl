#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        print"$query[$countryIndex]";
    }
}

main;


