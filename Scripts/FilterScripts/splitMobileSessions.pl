#!/usr/bin/perl -w

BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

$smartphoneSessionCounter=0;
$tabletSessionCounter=0;
$cellphoneCounter=0;

#open the files
open(FILESMART, ">SmartphoneDataset/sessionsFile.txt");
open(FILETABLET, ">TabletDataset/sessionsFile.txt");
open(FILECELL, ">CellphoneDataset/sessionsFile.txt");

sub queryToString{
    my ($session, $query) = @_;
    return "$session>>>$query[$ipIndex]>>>$query[$dateIndex]>>>$query[$browserIndex]>>>$query[$keywordsIndex]>>>$query[$cityIndex]>>>$query[$countryIndex]>>>$query[$deviceIndex]\n";
}

sub createNewSession{
    ($query,$device) = @_;
    if($device eq "Smartphone"){
        $smartphoneSessionCounter++;
        $newQuery = queryToString($smartphoneSessionCounter, $query);
        print FILESMART $newQuery;
    } elsif($device eq "Tablet"){
        $tabletSessionCounter++;
        $newQuery = queryToString($tabletSessionCounter, $query);
        print FILETABLET $newQuery;
    } else {
        $cellphoneCounter++;
        $newQuery = queryToString($cellphoneCounter, $query);
        print FILECELL $newQuery;
    }
}

sub addToSession {
    ($query,$device) = @_;
    if($device eq "Smartphone"){
        $newQuery = queryToString($smartphoneSessionCounter, $query);
        print FILESMART $newQuery;
    } elsif($device eq "Tablet"){
        $newQuery = queryToString($tabletSessionCounter, $query);
        print FILETABLET $newQuery;
    } else {
        $newQuery = queryToString($cellphoneCounter, $query);
        print FILECELL $newQuery;
    }
}

sub main {
    $currentSession=0;
    $currentDevice="";
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        chomp(@query);
        
        if($query[$sessionIdIndex] != $currentSession){
            #new session
            $currentSession = $query[$sessionIdIndex];
            if($query[$deviceIndex] eq "Smartphone" || $query[$deviceIndex] eq "Blackberry"){
                $currentDevice = "Smartphone";
            } elsif($query[$deviceIndex] eq "Tablet"){
                $currentDevice = "Tablet";
            } else {
                $currentDevice = "Cellphone";
            }
            createNewSession($_, $currentDevice);
        } else {
            addToSession($_,$currentDevice);
        }
    }
    
    close(FILESMART);
    close(FILETABLET);
    close(FILECELL);
}

main();

