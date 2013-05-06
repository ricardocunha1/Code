#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "browserRegex.pl";

$totalQueries=0;
%smartphones = ();

sub addToHash{
    $type = shift;
    if(exists($smartphones{$type})){
        $smartphones{$type}++;
    } else {
        $smartphones{$type}=1;
    }
}

sub processType{
    $browser = shift;
    
    if($browser =~ $browserRegex{androidPhone}){
        addToHash("Android");
    } elsif($browser =~ $browserRegex{iphone}){
        addToHash("iPhone");
    }elsif($browser =~ $browserRegex{windowsPhone}){
        addToHash("Windows Phone");
    }
    elsif($browser =~ $browserRegex{ipod}){
        addToHash("iPod");
    }
    elsif($browser =~ $browserRegex{blackberry}){
        addToHash("Blackberry");
    }
    
}

sub printResults {
    print "$totalQueries\n";
    foreach $device ( sort{$smartphones{$b} <=> $smartphones{$a}} keys %smartphones){
        print "$device>>>$smartphones{$device}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        chomp(@query);
        
        if($query[$deviceIndex] eq "Smartphone" || $query[$deviceIndex] eq "Blackberry"){ #neste momento incluo os BB na categoria dos SP
            processType($query[$browserIndex]);
            $totalQueries++;
        }
    }
    
    printResults;
}

main;

