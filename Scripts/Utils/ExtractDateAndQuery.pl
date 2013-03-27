#!/usr/bin/perl -w
=comment
Script que extrai a informação necessária para analisar a distribuição horária
    - data
    - tipo de dispositivo (mobile, smartphone, tablet)
    
Ricardo Cunha @ 2013
=cut
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

sub main{
    while($_ = <STDIN>) {
        my @query = split(/>>>/, $_);
        my $deviceType = getDeviceTypeInString(getDeviceType($query[$browserIndex]));
        
        print "$query[$dateIndex]>>>$deviceType\n";
        

        
    }
}

main;


