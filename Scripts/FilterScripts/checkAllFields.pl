#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

sub main {
    $counter=0;
    while($_ = <STDIN>){
        $counter++;
    }
    
    print "$counter\n";
}

main;


