#!/usr/bin/perl -w

=comment
Script para criar o ficheiro de sess›es, a partir do ficheiro de queries intermŽdio

Formato de cada linha: idSession>>>ip>>>date>>>browser>>>query>>>city>>>country
Ricardo Cunha @ 2013
=cut

#includes
use Date::Calc qw(:all);
use feature qw/switch/; 

#variables
%listIPs = ();
%currentQuery = ();

#counters
$totalQueries = 0;
$emptyQueries = 0;
$repeatedQueries = 0;
$sessionsOver100 = 0;

#constants
$sessionCutoff = 30; #in minutes
$maxQueries = 100; #max 100 queries per session

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
    
    return %tmp;
}

sub addToSession{
    #%tmp = cloneHash();
    my $tmp = {%currentQuery}; #tmp is a copy of currentQuery
    cloneHash();
    if(!removeQuery()){
        if(isIPonList($$tmp{"ip"})){
            #add the query
            if(isQueryOnList($$tmp{"ip"}, $$tmp{"date"})){ #repeated query
                $repeatedQueries++;
                return;
            }
        } else {
            #create a hash
            $listIPs{$$tmp{"ip"}} = {};
        }
        $listIPs{$$tmp{"ip"}}{$$tmp{"date"}} = $tmp;
        #print $listIPs{$$tmp{"ip"}}{$$tmp{"date"}}{"date"} . "\n";
    }
}

sub checkSessionCutoff {
    ($prevDate, $currentDate) = @_;

    $prevDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    @prev = ($1,$2,$3,$4,$5,$6);

    $currentDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    @current = ($1,$2,$3,$4,$5,$6);
    
    @dateDiff = Delta_YMDHMS($prev[0],$prev[1],$prev[2], $prev[3], $prev[4], $prev[5],
                   $current[0], $current[1], $current[2], $current[3], $current[4], $current[5]);
    
    $minutesDiff = $dateDiff[4];
    return ($minutesDiff < $sessionCutoff) ? 1 : 0; #true if the interval is less than 30:00
    #print "$dateDiff[4]\n";

}

sub printSession{
    #session counter
    my $sessionNumber = 1;

    open(FILE, ">sessionsFile.txt");
    foreach $ip (keys %listIPs){
        my $prevDate = 0;
        my $numberQueries = 0; #number of queries per session counter
        my $output = "";
        foreach $query (sort(keys %{$listIPs{$ip}})){
          #  print "$query\n";
            if($prevDate != 0 && !checkSessionCutoff($prevDate, $listIPs{$ip}{$query}{'date'})){ #outside cutoff range - new session
                if($output ne "" && $numberQueries < $maxQueries){
                    print FILE $output;
                } else {
                    $sessionsOver100 += $numberQueries;
                }
                $output = "";
                $numberQueries = 0;
                $sessionNumber++;
            }
            
            $output .= "$sessionNumber" . ">>>" . "$listIPs{$ip}{$query}{'ip'}" . ">>>" . "$listIPs{$ip}{$query}{'date'}" . ">>>" . "$listIPs{$ip}{$query}{'browser'}" .
            ">>>" . "$listIPs{$ip}{$query}{'keywords'}" . ">>>" . "$listIPs{$ip}{$query}{'city'}" .">>>" . "$listIPs{$ip}{$query}{'country'}\n";

            #inc session counter
            $numberQueries++;
            
            #update last known date
            $prevDate = $listIPs{$ip}{$query}{'date'};
        }
        if($output ne "" && $numberQueries < $maxQueries){
            print FILE $output;
        } else {
            $sessionsOver100 += $numberQueries;
        }
        
        $sessionNumber++;
    }
    close(FILE);
}

sub main{
    while($_ = <STDIN>){
        given($_){
            when($_ =~ m/^<query>$/i){
                undef(%currentQuery);

            }
            
            when($_ =~ m/^<\/query>$/i){
                $totalQueries++;
                addToSession();
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
        }
    }
    
    #prints
    printSession();
    print "The number of total queries is: $totalQueries\n";
    print "The number of empty queries is: $emptyQueries\n";
    print "The number of repeated queries is: $repeatedQueries\n";
    print "The number of queries that belong to sessions over 100 queries is: $sessionsOver100\n";
    
}

main;



