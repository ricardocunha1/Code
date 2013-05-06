#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "browserRegex.pl";

$totalQueries=0;
%tablets = ();

sub addToHash{
    $type = shift;
    if(exists($tablets{$type})){
        $tablets{$type}++;
    } else {
        $tablets{$type}=1;
    }
}

sub processType{
    $browser = shift;
    
    if($browser =~ $browserRegex{ipad}){
        addToHash("iPad");
    } elsif($browser =~ $browserRegex{androidTablet}){
        addToHash("Android");
    }elsif($browser =~ $browserRegex{playbookTablet}){
        addToHash("PlayBook");
    }
    elsif($browser =~ $browserRegex{hpTablet}){
        addToHash("HP");
    }
    
}

sub printResults {
    print "$totalQueries\n";
    foreach $device ( sort{$tablets{$b} <=> $tablets{$a}} keys %tablets){
        print "$device>>>$tablets{$device}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        chomp(@query);
        
        if($query[$deviceIndex] eq "Tablet"){
            processType($query[$browserIndex]);
            $totalQueries++;
        }
    }

    printResults;
}

main;

