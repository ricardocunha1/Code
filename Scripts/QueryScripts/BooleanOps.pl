#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

$totalQueries=0;
$booleanQueries=0;

$moreQueries=0;
$notQueries=0;
$andQueries=0;
$orQueries=0;
$siteQueries=0;
$fileQueries=0;
$phraseQueries=0;
$fillQueries=0;


$totalSessions=0;
$booleanSessions=0;
$hasBooleanQuery=0;

sub isBooleanOp{
    my $query = shift;
    my $isBoolean=0;
    if($query =~ m/\s+\+\s+/i){#MORE "+"
        $moreQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/\s+\-\s+/i){ #NOT "-"
        $notQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/\s+AND\s+/i){#AND
        $andQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/\s+OR\s+/i){#OR
        $orQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/(\s+)site:/i || $query =~ m/^site:/i){#SITE 
        $siteQueries++;
        $isBoolean=1;
    }
        
    if($query =~ m/(\s+)filetype:/i || $query =~ m/^filetype:/i){#FILE 
        $fileQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/\"(.+)\"/i){#PHRASE
        $phraseQueries++;
        $isBoolean=1;
    }
    
    if($query =~ m/(\s+)[a-zA-Z0-9]+\*/i || $query =~ m/^[a-zA-Z0-9]+\*/i){#FILL 1
        $fillQueries++;
        $isBoolean=1;
    }
    
    return $isBoolean;

}

sub checkBooleanOps{
    $query = shift;
    if(isBooleanOp($query)){
        $booleanQueries++;
        if($hasBooleanQuery==0){
            $hasBooleanQuery=1;
            $booleanSessions++;
        }
    }
    
}

sub printResults{
    print "$booleanQueries>>>$totalQueries\n";
    print "$booleanSessions>>>$totalSessions\n";
    print "$moreQueries\n";
    print "$notQueries\n";
    print "$andQueries\n";
    print "$orQueries\n";
    print "$siteQueries\n";
    print "$fileQueries\n";
    print "$phraseQueries\n";
    print "$fillQueries\n";
    
}

sub main{
    $currentSession = 0;
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        if($query[$sessionIdIndex] != $currentSession){
            $hasBooleanQuery=0;
            $currentSession = $query[$sessionIdIndex];
            $totalSessions++;
        }
        
        checkBooleanOps($query[$keywordsIndex]);
        $totalQueries++;
    }
    
    printResults;
}

main;


