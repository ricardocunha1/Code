#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%tabletQueries = ();
%smartphoneQueries = ();
%cellphoneQueries = ();

$totalTabletQueries = 0;
$totalSmartphoneQueries = 0;
$totalCellphoneQueries = 0;

sub addToTabletHash {
    $query = shift;
    if(exists($tabletQueries{$query})){
        $tabletQueries{$query}++;
    }
    else {
        $tabletQueries{$query}=1;
    }
}

sub addToCellphoneHash {
    $query = shift;
    if(exists($cellphoneQueries{$query})){
        $cellphoneQueries{$query}++;
    }
    else {
        $cellphoneQueries{$query}=1;
    }
}

sub addToSmartphoneHash {
    $query = shift;
    if(exists($smartphoneQueries{$query})){
        $smartphoneQueries{$query}++;
    }
    else {
        $smartphoneQueries{$query}=1;
    }
}

sub printResults{
    $counter = 0;
    print "$totalTabletQueries>>>$totalSmartphoneQueries>>>$totalCellphoneQueries\n";
    foreach $query (sort{$tabletQueries{$b} <=> $tabletQueries{$a}} keys %tabletQueries) {
        if($counter == 1000){
            last;
        } else {
            print "$query>>>$tabletQueries{$query}\n";
        }
        
        $counter++;
    }
    
    $counter = 0;
    
    print "smartphone\n";
    
    foreach $query (sort{$smartphoneQueries{$b} <=> $smartphoneQueries{$a}} keys %smartphoneQueries) {
        if($counter == 1000){
            last;
        } else {
            print "$query>>>$smartphoneQueries{$query}\n";
        }
        
        $counter++;
    }
    $counter=0;
    print "cellphone\n";
    
    foreach $query (sort{$cellphoneQueries{$b} <=> $cellphoneQueries{$a}} keys %cellphoneQueries) {
        if($counter == 1000){
            last;
        } else {
            print "$query>>>$cellphoneQueries{$query}\n";
        }
        
        $counter++;
    }
    
    
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        chomp(@query);
        
        if($query[$deviceIndex] eq "Tablet"){
            addToTabletHash($query[$keywordsIndex]);
            $totalTabletQueries++;
        } elsif($query[$deviceIndex] eq "Other Mobile Devices"){
            addToCellphoneHash($query[$keywordsIndex]);
            $totalCellphoneQueries++;
        } else {
            addToSmartphoneHash($query[$keywordsIndex]);
            $totalSmartphoneQueries++;
        }
    }
    
    printResults;
}

main;


