#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

use DateTime;
use feature qw/switch/;
use BerkeleyDB;

%queriesByIP = ();
tie %queriesByIP, 'BerkeleyDB::Btree',
              -Filename => "hash.db",
              -Compare  => sub { $_[0] cmp $_[1] },
              -Flags    => DB_CREATE;
              
$sessionNumber = 1;

$previousTotalQueries = 0;
$repeatedQueries = 0;
$sessionsOver100 = 0;
$numberQueries = 0;

$totalQueries = 0;

#constants
$sessionCutoff = 5; #in minutes
$maxQueries = 20; #max 10 queries per session

open(FILE, ">PCDataset/sessionsFile.txt");

sub checkSessionCutoff {
    ($prevDate, $currentDate) = @_;
    $prevDate = "20130".$prevDate;
    $currentDate = "20130".$currentDate;
    
    $prevDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    $prev = DateTime->new(
        year       => $1,
        month      => $2,
        day        => $3,
        hour       => $4,
        minute     => $5,
        second     => $6  
    );

    $currentDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    $current = DateTime->new(
        year       => $1,
        month      => $2,
        day        => $3,
        hour       => $4,
        minute     => $5,
        second     => $6
    );
    
    $interval = DateTime::Duration->new(minutes => $sessionCutoff);
    return ($current - $interval <= $prev) ? 1: 0;

}

sub isQueryOnList {
    $date = shift;
    return exists($queriesByIP{$date});
}

sub addToSessionsFile {
    my $prevDate = 0;
    my $numberQueries = 0; #number of queries per session counter
    my $output = "";
    foreach $date (keys %queriesByIP){
        if($prevDate != 0 && !checkSessionCutoff($prevDate, $date)){
            if($output ne "" && $numberQueries < $maxQueries){
                    print FILE $output;
                #    print "$output\n";
                    $totalQueries += $numberQueries;
                } else {
                    $sessionsOver100 += $numberQueries;
                }
                $output = "";
                $numberQueries = 0;
                $sessionNumber++;
        }
        
        $output .= "$sessionNumber" . ">>>" . $queriesByIP{$date};
        
        #inc session counter
        $numberQueries++;
        
        #update last known date
        $prevDate = $date;
    }
    
    if($output ne "" && $numberQueries < $maxQueries){
        print FILE $output;
       # print "$output\n";
        $totalQueries += $numberQueries;
            
    } else {
        $sessionsOver100 += $numberQueries;
    }
    $sessionNumber++;
        
    
    
}

sub main {
    my $currentIp = "";
    while($_ = <STDIN>){
        $previousTotalQueries++;
        print "$previousTotalQueries\n";
        @query = split(/>>>/, $_);
        if($currentIp eq ""){
            $currentIp = $query[$ipIndex-1];
        }
        
        if($query[$ipIndex-1] ne $currentIp){
            addToSessionsFile();
            undef(%queriesByIP);
            $currentIp = $query[$ipIndex-1];
        }
        else {
            my $date = $query[$dateIndex-1];
            $date =~ m/([0-9]{5})([0-9]{9})/;
            $partialDate = $2;
            if(isQueryOnList($partialDate)){
                #query repetida
                $repeatedQueries++;
            } else {
                $queriesByIP{$partialDate} = $_;
            }
        }
    }
    
    print "The number of total initial queries is: $previousTotalQueries\n";
    print "The number of repeated queries is: $repeatedQueries\n";
    print "The number of queries that belong to sessions over 100 queries is: $sessionsOver100\n";
    print "The total number of queries is: $totalQueries\n";
}

main;
close(FILE)

