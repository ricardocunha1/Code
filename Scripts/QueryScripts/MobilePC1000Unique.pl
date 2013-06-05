#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%desktopQueries = ();
%mobileQueries = ();

$totalDesktopQueries = 0;
$totalMobileQueries = 0;

sub addToDesktopHash {
    $query = shift;
    if(exists($desktopQueries{$query})){
        $desktopQueries{$query}++;
    }
    else {
        $desktopQueries{$query}=1;
    }
}

sub addToMobileHash {
    $query = shift;
    if(exists($mobileQueries{$query})){
        $mobileQueries{$query}++;
    }
    else {
        $mobileQueries{$query}=1;
    }
}

sub printResults{
    $counter = 0;
    print "$totalDesktopQueries>>>$totalMobileQueries\n";
    foreach $query (sort{$desktopQueries{$b} <=> $desktopQueries{$a}} keys %desktopQueries) {
        if($counter == 1000){
            last;
        } else {
            print "$query>>>$desktopQueries{$query}\n";
        }
        
        $counter++;
    }
    
    $counter = 0;
    
    print "mobile\n";
    
    foreach $query (sort{$mobileQueries{$b} <=> $mobileQueries{$a}} keys %mobileQueries) {
        if($counter == 1000){
            last;
        } else {
            print "$query>>>$mobileQueries{$query}\n";
        }
        
        $counter++;
        
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        chomp(@query);
        
        if($query[$deviceIndex] eq "Desktop"){
            addToDesktopHash($query[$keywordsIndex]);
            $totalDesktopQueries++;
        } else {
            addToMobileHash($query[$keywordsIndex]);
            $totalMobileQueries++;
        }
    }
    
    printResults;
}

main;


