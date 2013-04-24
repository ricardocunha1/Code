#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
require "checkDeviceType.pl";

%queries = ();
$urlQueries = 0;


sub isURL{
    $query = shift;
    if($query =~ m/^(http:|www\.)/i || $query =~ m/(\.com|\.net|\.org|\.pt)/i){
        return 1;
    }
    
    return 0;
}

sub addQuery {
    $query = shift;
    if(exists($queries{$query})){
        $queries{$query}++;
    } else {
        $queries{$query} = 1;
    }
}

sub printResults {
    foreach $query ( sort{$queries{$b} <=> $queries{$a}} keys %queries){
        print "$query>>>$queries{$query}\n";
    }
    print "URLs>>>$urlQueries\n";
}

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        my $keywords = lc($query[$keywordsIndex]);
        
        if($keywords ne ""){
            addQuery($keywords);
        }
        
        if(isURL($keywords)){
            $urlQueries++;
        }
  
    }
    
    printResults();
    
    
}

main;


