#!/usr/bin/perl -w

#includes
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

use DateTime;
use feature qw/switch/;
#use DB_File;
use DB_File;

#variables
%listIPs = ();
%currentQuery = ();

#counters
$previousTotalQueries = 0;
$emptyQueries = 0;
$repeatedQueries = 0;
$sessionsOver100 = 0;
$spamQueries=0;

$totalQueries=0;

#constants
$sessionCutoff = 5; #in minutes
$maxQueries = 20; #max 10 queries per session

sub compare
{
    my ($key1, $key2) = @_ ;
    key2 cmp key1;
}

sub isIPonList {
    $ip = shift;
    return exists($listIPs{$ip});
}

sub isQueryOnList {
    $ip = shift;
    $date = shift;
    return exists($listIPs{$ip}{$date});
}

sub removeQuery{
    #empty query
    if($currentQuery{"keywords"} eq "EMPTY"){
        $emptyQueries++;
        return 1;
    }
    #repeated queries
    #session with 100+ queries
    return 0;
}


sub cloneHash{
    my %tmp = ();
    $tmp{'ip'} = $currentQuery{'ip'};
    $tmp{'date'} = $currentQuery{'date'};
    $tmp{'browser'} = $currentQuery{'browser'};
    $tmp{'keywords'} = $currentQuery{'keywords'};
    $tmp{'city'} = $currentQuery{'city'};
    $tmp{'country'} = $currentQuery{'country'};
    $tmp{'device'} = $currentQuery{'device'};
    
    return %tmp;
}

sub hashToString{
    return "$currentQuery{'ip'}" . ">>>" . "$currentQuery{'date'}" . ">>>" . "$currentQuery{'browser'}" .
            ">>>" . "$currentQuery{'keywords'}" . ">>>" . "$currentQuery{'city'}" .">>>" . "$currentQuery{'country'}" .
            ">>>" . "$currentQuery{'device'}";
}

sub addToSession{
    #%tmp = cloneHash();
 #   my $tmp = {%currentQuery}; #tmp is a copy of currentQuery
   # cloneHash();
    if(!removeQuery()){
        if(isIPonList($currentQuery{"ip"})){
            #add the query
            $currentQuery{"date"} =~ m/([0-9]{5})([0-9]{9})/;
            if(isQueryOnList($currentQuery{"ip"}, $2)){ #repeated query
                $repeatedQueries++;
                return;
            }
        } else {
            #create a hash
            $listIPs{$currentQuery{"ip"}} = {};
            tie(%{$listIPs{$currentQuery{"ip"}}}, 'DB_File', $currentQuery{'ip'} . ".dbfile", $DB_BTREE);
        }
        my $queryString = hashToString();
        $currentQuery{"date"} =~ m/([0-9]{5})([0-9]{9})/;
        $listIPs{$currentQuery{"ip"}}{$2} = $queryString;
        #print $listIPs{$$tmp{"ip"}}{$$tmp{"date"}}{"date"} . "\n";
    }
}

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

sub printSession{
    #session counter
    my $sessionNumber = 1;

    open(FILE, ">PCDataset/sessionsFile2.txt");
    while (($ip,%queries) = each %listIPs) {
 #   foreach $ip (keys %listIPs){
        my $prevDate = 0;
        my $numberQueries = 0; #number of queries per session counter
        my $output = "";
      #  while (($date,$val) = each %{$queries}) {
        foreach $date (sort keys %{$listIPs{$ip}}){
            $val = $listIPs{$ip}{$date};
          #  print "$query\n";
            if($prevDate != 0 && !checkSessionCutoff($prevDate, $date)){ #outside cutoff range - new session
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
            
            $output .= "$sessionNumber" . ">>>" . $val . "\n";
            

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
    close(FILE);
}

sub queryIsOK{
    if($currentQuery{'keywords'} eq "404 s" || $currentQuery{'keywords'} eq "le m" ||
       $currentQuery{'keywords'} =~ m/lyncdiscover/i){
        return 0;
    }
    
    elsif($currentQuery{'keywords'} =~ m/theme|plugin/i || $currentQuery{'keywords'} =~ m/escape\(keywords\)/i ||
          $currentQuery{'keywords'} =~ m/greatgol/i || $currentQuery{'keywords'} =~ m/.php/i ||
          $currentQuery{'keywords'} =~ m/\/(.*?)\//i || $currentQuery{'keywords'} =~ m/powered by/i ||
          $currentQuery{'keywords'} =~ m/u-design/i || $currentQuery{'keywords'} =~ m/^inurl:/i){
        return 0;
    }
    elsif($currentQuery{'ip'} eq "208.100.11.200" || $currentQuery{'ip'} eq "195.189.142.81" || $currentQuery{'ip'} eq "78.106.210.80"){
        return 0;
    }
    elsif($currentQuery{'city'} eq "Mountain View"){
        return 0;
    }
    
    return 1;
}

sub main{
    while($_ = <STDIN>){
        given($_){
            when($_ =~ m/^<query>$/i){
                undef(%currentQuery);
            }
            
            when($_ =~ m/^<\/query>$/i){
                $previousTotalQueries++;
                print "$previousTotalQueries\n";
                if(queryIsOK()){
                    addToSession();
                } else {
                    $spamQueries++;
                }
            }
            
            when($_ =~ m/^<date>(.*?)<\/date>$/i){
                $currentQuery{'date'} = $1;
            }
            
            when($_ =~ m/^<ip>(.*?)<\/ip>$/i){
                $currentQuery{'ip'} = $1;
            }
            
            when($_ =~ m/^<browser>(.*?)<\/browser>$/i){
                $currentQuery{'browser'} = $1;
            }
            
            when($_ =~ m/^<keywords>(.*?)<\/keywords>$/i){
                $currentQuery{'keywords'} = $1;
            }
            
            when($_ =~ m/^<city>(.*?)<\/city>$/i){
                $currentQuery{'city'} = $1;
            }
            
            when($_ =~ m/^<country>(.*?)<\/country>$/i){
                $currentQuery{'country'} = $1;
            }
            
            when($_ =~ m/^<device>(.*?)<\/device>$/i){
                $currentQuery{'device'} = $1;
            }
        }
    }
    
    #prints
    printSession();
    print "The number of total initial queries is: $previousTotalQueries\n";
    print "The number of empty queries is: $emptyQueries\n";
    print "The number of repeated queries is: $repeatedQueries\n";
    print "The number of queries that belong to sessions over 100 queries is: $sessionsOver100\n";
    print "The number of spam queries is: $spamQueries\n";
    print "The total number of queries is: $totalQueries\n";

    
}

main;


