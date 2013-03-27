#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        my $deviceType = getDeviceTypeInString(getDeviceType($query[$browserIndex]));
        
        print "$query[$keywordsIndex]>>>$deviceType\n";
        
        
    }
}

main;


