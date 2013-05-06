#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

$totalQueries=0;
%hash = ();

sub isCityOnHash{
    $city = shift;
    return exists($hash{$city});
}

sub addCity{
    $city = shift;
    if(isCityOnHash($city)){
        $hash{$city}++;
    } else {
        $hash{$city} = 1;
    }
    
}

sub printHash{
    $counter=0;
    print "$totalQueries\n";
    foreach $key (sort{$hash{$b} <=> $hash{$a}} keys %hash){
        if($counter<20){
            print "$key>>>$hash{$key}\n";
            $counter++;
        } else {
            return;
        }
    }
}

sub main{
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        if($query[$cityIndex] ne "EMPTY"){
            $totalQueries++;
            addCity($query[$cityIndex]);
        }
    }
    
    printHash;
}

main;


