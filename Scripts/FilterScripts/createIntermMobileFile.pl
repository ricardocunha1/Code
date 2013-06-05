#!/usr/bin/perl -w
use feature qw/switch/;
%currentQuery = ();

$previousTotalQueries = 0;
$emptyQueries = 0;
$spamQueries=0;

$totalQueries=0;

open(FILE, ">MobileDataset/intermFile.txt");

sub hashToString{
    return "$currentQuery{'ip'}" . ">>>" . "$currentQuery{'date'}" . ">>>" . "$currentQuery{'browser'}" .
            ">>>" . "$currentQuery{'keywords'}" . ">>>" . "$currentQuery{'city'}" .">>>" . "$currentQuery{'country'}" .
            ">>>" . "$currentQuery{'device'}";
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

sub addToFile {
    my $queryString = hashToString();
    if(!removeQuery()){
        my $output = "$queryString\n";
        print FILE $output;
        $totalQueries++;
    }
}

sub main {
    while($_ = <STDIN>){
        given($_){
            when($_ =~ m/^<query>$/i){
                undef(%currentQuery);
            }
            
            when($_ =~ m/^<\/query>$/i){
                $previousTotalQueries++;
                print "$previousTotalQueries\n";
                if(queryIsOK()){
                    addToFile();
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
    
    print "The number of total initial queries is: $previousTotalQueries\n";
    print "The number of empty queries is: $emptyQueries\n";
    print "The number of spam queries is: $spamQueries\n";
    print "The total number of queries is: $totalQueries\n";
}

main;
close(FILE);


