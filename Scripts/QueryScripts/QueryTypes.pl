#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

#Initial, modified, new and identical queries
$currentSession=0;
$counterInitial=0;
$counterIdentical=0;
$counterModified=0;
$counterNew=0;

@modifiedArray = (0) x 11;
@queryOverlap = ();

$lastQuery="";
=comment
    0 - new
    1 - modified
    2- identical
=cut
sub getQueryType{
    $currentQuery = shift;
    if($currentQuery eq $lastQuery){
        return 2;
    }
    
    @lastWords = split(" ", $lastQuery);
    @currentWords = split(" ", $currentQuery);
    
    foreach $currentWord (@currentWords){
        foreach $lastWord (@lastWords){
            if($currentWord eq $lastWord){
                return 1;
            }
        }
    }
    
    return 0;
}

sub addToModifiedQuery{
    my $lengthDiff = shift;
    my $hashIndex = 0;
    if($lengthDiff <= -5){
        $hashIndex = 0;
    } elsif($lengthDiff >= 5){
        $hashIndex = 10;
    } else {
        $hashIndex = $lengthDiff + 5;
    }
    
    $modifiedArray[$hashIndex]++;
}

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
    
    #calculate query overlap
    foreach $last (@lastWords){
        foreach $current (@currentWords){
            
            if($last eq $current){
                $overlapCounter++;
            }
        }
    }
    return($overlapCounter/scalar(@uniqueWords));
}

sub processModifiedQuery{
    $currentQuery = shift;
    @lastWords = split(" ", $lastQuery);
    @currentWords = split(" ", $currentQuery);
    
    #query terms changes
    my $lengthDiff = scalar(@currentWords) - scalar(@lastWords);
    addToModifiedQuery($lengthDiff);
    
    #calculate query overlap
    push(@queryOverlap, getQueryOverlap($currentQuery));
    
}

sub processQuery{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    
    if($type == 0){
        $counterNew++;
    } elsif($type == 1){
        processModifiedQuery($currentQuery);
        $counterModified++;
    } elsif($type == 2){
        $counterIdentical++;
    }
}

sub printResults{
    print "Initial>>>$counterInitial\n";
    print "New>>>$counterNew\n";
    print "Identical>>>$counterIdentical\n";
    print "Modified>>>$counterModified\n";
    
    print "ModifiedLengthDiff\n";
    my $i=0;
    while($i < 11){
        my $lengthDiff = $i-5;
        print "$lengthDiff>>>$modifiedArray[$i]\n";
        $i++;
    }
    
    print "overlap\n";
    foreach $overlap (@queryOverlap){
        print "$overlap\n";
    }
    
}

sub main{
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        
        if($query[$sessionIdIndex] != $currentSession){
            $currentSession = $query[$sessionIdIndex];
            $counterInitial++;
        } else {
            processQuery(lc($query[$keywordsIndex]));
        }
        $lastQuery = lc($query[$keywordsIndex]);
        
    }
    
    printResults;
}

main;


