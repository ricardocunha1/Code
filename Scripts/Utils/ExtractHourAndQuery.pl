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
        chomp(@query);
        
        if($query[$dateIndex] =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i){
            print "$4>>>$query[$deviceIndex]\n";
        }
        
    }
}

main;


