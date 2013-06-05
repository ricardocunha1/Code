#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

@tabletQueryOverlap = ();
@smartphoneQueryOverlap = ();
@cellphoneQueryOverlap = ();

$currentSession=0;
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

sub addTabletQuery
{
    $currentQuery = shift;

    #calculate query overlap
    push(@tabletQueryOverlap, getQueryOverlap($currentQuery));
}

sub addCellphoneQuery
{
    $currentQuery = shift;

    #calculate query overlap
    push(@cellphoneQueryOverlap, getQueryOverlap($currentQuery));
}

sub addSmartphoneQuery
{
    $currentQuery = shift;

    #calculate query overlap
    push(@smartphoneQueryOverlap, getQueryOverlap($currentQuery));
}

sub processTabletQuery
{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    if($type == 1)
    {
        addTabletQuery($currentQuery);
    }
}

sub processCellphoneQuery
{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    if($type == 1)
    {
        addCellphoneQuery($currentQuery);
    }
}

sub processSmartphoneQuery
{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    if($type == 1)
    {
        addSmartphoneQuery($currentQuery);
    }
}

sub printResults{
    foreach $overlap (@tabletQueryOverlap)
    {
        print "$overlap\n";
    }
    print "smartphone\n";
    
    foreach $overlap (@smartphoneQueryOverlap)
    {
        print "$overlap\n";
    }
    
    print "cellphone\n";
    
    foreach $overlap (@cellphoneQueryOverlap)
    {
        print "$overlap\n";
    }
    
}

sub main {
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        chomp(@query);
        
        if($query[$sessionIdIndex] != $currentSession){
            $currentSession = $query[$sessionIdIndex];
            
            
        } else {
            if($query[$deviceIndex] eq "Tablet"){
                processTabletQuery(lc($query[$keywordsIndex]));
            } elsif($query[$deviceIndex] eq "Other Mobile Devices"){
                processCellphoneQuery(lc($query[$keywordsIndex]));
            } else {
                processSmartphoneQuery(lc($query[$keywordsIndex]));
            }
        }
        $lastQuery = lc($query[$keywordsIndex]);
    }
    
    printResults;
}

main;


