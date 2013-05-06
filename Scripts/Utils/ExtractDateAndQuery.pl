#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

sub main{
    while($_ = <STDIN>) {
        my @query = split(/>>>/, $_);
        chomp(@query);
        
        print "$query[$dateIndex]>>>$query[$deviceIndex]\n";
        
    }
}

main;


