#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

$totalQueries=0;
%hash = ();

sub isCountryOnHash{
    $country = shift;
    return exists($hash{$country});
}

sub addCountry{
    $country = shift;
    if(isCountryOnHash($country)){
        $hash{$country}++;
    } else {
        $hash{$country} = 1;
    }
    
}

sub printHash{
    $counter=0;
    print "$totalQueries\n";
    foreach $key (sort{$hash{$b} <=> $hash{$a}} keys %hash){
        if($counter<10){
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
        chop($query[$countryIndex]);
        if($query[$countryIndex] ne "EMPTY"){
            $totalQueries++;
            addCountry($query[$countryIndex]);
        }
    }
    
    printHash;
}

main;



