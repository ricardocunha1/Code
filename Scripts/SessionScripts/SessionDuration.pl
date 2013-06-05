#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "checkDeviceType.pl";
require "sessionFileIndexes.pl";

use Date::Calc qw(:all);

%hash = ();
$neg=0;
sub initializeHash{
    $hash{"[0,1["} = 0;
    $hash{"[1,5["} = 0;
    $hash{"[5,10["} = 0;
    $hash{"[10,15["} = 0;
    $hash{"[15,30["} = 0;
    $hash{"[30,60["} = 0;
    $hash{"[60,120["} = 0;
    $hash{"[120,180["} = 0;
    $hash{"[180,240["} = 0;
    $hash{"[240+["} = 0;
}

sub addDiffToHash {
    my $diff = shift;
    #print "$diff\n";
    if($diff == 0){
        $key = "[0,1[";
    } elsif($diff >= 1 && $diff < 5){
        $key = "[1,5[";
    } elsif($diff >=5 && $diff < 10){
        $key = "[5,10[";
    } elsif($diff >= 10 && $diff < 15){
        $key = "[10,15[";
    } elsif($diff >= 15 && $diff < 30){
        $key = "[15,30[";
    } elsif($diff >= 30 && $diff < 60){
        $key = "[30,60[";
    } elsif($diff >= 60 && $diff < 120){
        $key = "[60,120[";
    } elsif($diff >= 120 && $diff < 180){
        $key = "[120,180[";
    } elsif($diff >= 180 && $diff < 240){
        $key = "[180,240[";
    } elsif($diff >= 240){
        $key = "[240+[";
    } else {
        $key = "neg";
    }
    
    #print "$key\n";
    
    if($key ne "neg"){
        my $counter = $hash{$key};
        $counter++;
        $hash{$key} = $counter;
    } else {
        $neg++;
    }
}

sub checkSessionDuration {
    ($prevDate, $currentDate) = @_;
    
    if($prevDate eq $currentDate){
        my $counter = $hash{"[0,1["};
        $counter++;
        $hash{"[0,1["} = $counter;
        return;
    }

    $prevDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    @prev = ($1,$2,$3,$4,$5,$6);

    $currentDate =~ m/([0-9]{4})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})([0-9]{02})/i;
    @current = ($1,$2,$3,$4,$5,$6);
    
    @dateDiff = Delta_YMDHMS($prev[0],$prev[1],$prev[2], $prev[3], $prev[4], $prev[5],
                   $current[0], $current[1], $current[2], $current[3], $current[4], $current[5]);
    
    $minutesDiff = $dateDiff[4];
    #print "$minutesDiff\n";
    #add difference to intervals hash
    addDiffToHash($minutesDiff);
    
    #print difference to stdout
    print "$dateDiff[4]>>>$dateDiff[5]\n";

}


sub main{
    initializeHash;
    $totalNumberSessions=0;
    $currentSession = 0;
    $firstSessionDate = "";
    $lastSessionDate = "";
    
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        #
        if($query[$sessionIdIndex] != $currentSession){
            if($currentSession > 0){
                checkSessionDuration($firstSessionDate, $lastSessionDate);
            }
            
            $firstSessionDate = $query[$dateIndex];
            $lastSessionDate = $query[$dateIndex];
            $totalNumberSessions++;
            $currentSession = $query[$sessionIdIndex];
        } else {
            $lastSessionDate = $query[$dateIndex];
        }
        
    }
    
 #   print "$neg\n";

    print "intervals\n";
   foreach $key (keys %hash){
       print "$key>>>$hash{$key}\n";
    }
}

main;


