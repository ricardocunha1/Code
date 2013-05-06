#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%deviceType = ();

sub addToHash {
    $device = shift;
    if(exists($deviceType{$device})){
        $deviceType{$device}++;
    } else {
        $deviceType{$device}=1;
    }
}

sub printResults {
    foreach $device ( sort{$deviceType{$b} <=> $deviceType{$a}} keys %deviceType){
        print "$device>>>$deviceType{$device}\n";
    }
}

sub main {
    $totalQueries=0;
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        chomp(@query);
        addToHash($query[$deviceIndex]);
        $totalQueries++;
        
    }
    print "$totalQueries\n";
    printResults;
}

main;


