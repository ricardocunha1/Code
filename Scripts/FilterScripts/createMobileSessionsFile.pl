#!/usr/bin/perl -w

=comment
Script para criar o ficheiro de sess›es, a partir do ficheiro de queries intermŽdio

Formato de cada linha: idSession>>>ip>>>date>>>browser>>>query>>>city>>>country
Ricardo Cunha @ 2013
=cut



#includes
use DateTime;
use feature qw/switch/;
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

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

sub isIPonList {
    $ip = shift;
    return exists($listIPs{$ip});
}

sub isQueryOnList {
    ($ip, $date, $keywords, $browser) = @_;
    if(exists($listIPs{$ip}{$date})){
      #  @query = split(/>>>/, "1>>>".$listIPs{$ip}{$date});
     #   if($query[$keywordsIndex] eq $keywords && $query[$browserIndex] eq $browser){
      #      return 1;
     #   }
     return 1;
    }
    
    return 0;
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
            if(isQueryOnList($currentQuery{"ip"}, $currentQuery{"date"}, $currentQuery{"keywords"}, $currentQuery{"browser"})){ #repeated query
                $repeatedQueries++;
                return;
            }
        } else {
            #create a hash
            $listIPs{$currentQuery{"ip"}} = {};
        }
        my $queryString = hashToString();
        $listIPs{$currentQuery{"ip"}}{$currentQuery{"date"}} = $queryString;
        #print $listIPs{$$tmp{"ip"}}{$$tmp{"date"}}{"date"} . "\n";
    }
}

sub checkSessionCutoff {
    ($prevDate, $currentDate) = @_;

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

    open(FILE, ">MobileDataset/sessionsFile.txt");
    foreach $ip (keys %listIPs){
        my $prevDate = 0;
        my $numberQueries = 0; #number of queries per session counter
        my $output = "";
        foreach $date (sort(keys %{$listIPs{$ip}})){
          #  print "$query\n";
            if($prevDate != 0 && !checkSessionCutoff($prevDate, $date)){ #outside cutoff range - new session
                if($output ne "" && $numberQueries < $maxQueries){
                    print FILE $output;
                    $totalQueries += $numberQueries;
                } else {
                    $sessionsOver100 += $numberQueries;
                }
                $output = "";
                $numberQueries = 0;
                $sessionNumber++;
            }
            
            $output .= "$sessionNumber" . ">>>" . $listIPs{$ip}{$date} . "\n";

            #inc session counter
            $numberQueries++;
            
            #update last known date
            $prevDate = $date;
        }
        if($output ne "" && $numberQueries < $maxQueries){
            print FILE $output;
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
          $currentQuery{'keywords'} =~ m/www.globalangels.org/i){
        return 0;
    }
    elsif($currentQuery{'ip'} eq "208.100.11.200" || $currentQuery{'ip'} eq "195.189.142.81"){
        return 0;
    }
    elsif($currentQuery{'city'} =~ m/Chino Hills/i || $currentQuery{'city'} =~ m/Oslo/i || $currentQuery{'city'} =~ m/San Francisco/i ||
          $currentQuery{'city'} =~ m/Nokia/i || $currentQuery{'city'} =~ m/Dobrichovice/i || $currentQuery{'city'} =~ m/Salw/i ||
          $currentQuery{'city'} =~ m/Saint Petersburg/i || $currentQuery{'city'} =~ m/Seoul/i || $currentQuery{'city'} =~ m/Rzesz/i ||
          $currentQuery{'city'} =~ m/Bangkok/i || $currentQuery{'city'} =~ m/Frederick/i){
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



