#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
use DB_File;
%uniqueMobileQueries = ();
%uniquePCQueries = ();

tie(%uniqueMobileQueries, 'DB_File', "uniqueMobile.dbfile", $DB_BTREE);
tie(%uniquePCQueries, 'DB_File', "uniquePC.dbfile", $DB_BTREE);

$totalMobileQueries = 0;
$totalPCQueries = 0;

sub addMobileUniqueQueries{
    my $query = shift;
    if(exists($uniqueMobileQueries{$query})){
        $uniqueMobileQueries{$query}++;
    } else {
        $uniqueMobileQueries{$query} = 1;
    }
    
    $totalMobileQueries++;
    
}

sub addPCUniqueQueries{
    my $query = shift;
    if(exists($uniquePCQueries{$query})){
        $uniquePCQueries{$query}++;
    } else {
        $uniquePCQueries{$query} = 1;
    }
    
    $totalPCQueries++;
    
}

sub printResults {
    #print mobile queries
    my $numberMobileUnique = scalar(keys %uniqueMobileQueries);
    print "mobilequeries>>>$totalMobileQueries>>>$numberMobileUnique\n";
    foreach $query (sort{$uniqueMobileQueries{$b} <=> $uniqueMobileQueries{$a}} keys %uniqueMobileQueries){
        print "$query>>>$uniqueMobileQueries{$query}\n";
    }
    
    #print mobile queries
    my $numberPCUnique = scalar(keys %uniquePCQueries);
    print "desktopqueries>>>$totalPCQueries>>>$numberPCUnique\n";
    foreach $query (sort{$uniquePCQueries{$b} <=> $uniquePCQueries{$a}} keys %uniquePCQueries){
        print "$query>>>$uniquePCQueries{$query}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        chomp(@query);
        
        $keywords = lc($query[$keywordsIndex]);
        if($query[$deviceIndex] eq "Desktop"){
            addPCUniqueQueries($keywords);
        } else{
            addMobileUniqueQueries($keywords);
        }
        
        
        
    }
    
    printResults();
}

main;
untie(%uniqueMobileQueries);
untie(%uniquePCQueries);


