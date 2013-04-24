#!/usr/bin/perl -w

$lastQuery = "weather london";

sub existsOnUniqueWords{
    my @uniqueWords = @{$_[0]};
    my $last = ${$_[1]};
    
    foreach $word (@uniqueWords){
        if($word eq $last){
            return 1;
        }
    }
    
    return 0;
}

sub getQueryOverlap{
    $currentQuery = shift;
    #build unique terms array
    @lastWords = split(" ", $lastQuery);
    @currentWords = split(" ", $currentQuery);
    @uniqueWords = ();
    $overlapCounter = 0;
    
    foreach $last (@lastWords){
        if(!existsOnUniqueWords(\@uniqueWords,\$last)){
            push(@uniqueWords,$last);
        }
    }
    
    foreach $current (@currentWords){
        if(!existsOnUniqueWords(\@uniqueWords,\$current)){
            push(@uniqueWords,$current);
        }
    }
    
    foreach $last (@lastWords){
        foreach $current (@currentWords){
            #overlap
            if($last eq $current){
                $overlapCounter++;
            }
        }
    }
    print "$overlapCounter" . scalar(@uniqueWords) . "\n";
    return($overlapCounter/scalar(@uniqueWords));
}

$x = getQueryOverlap("weather dublin");
print "$x\n";



