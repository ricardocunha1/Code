#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

@mobileQueryOverlap = ();
@pcQueryOverlap = ();

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

sub addDesktopQuery
{
    $currentQuery = shift;

    #calculate query overlap
    push(@pcQueryOverlap, getQueryOverlap($currentQuery));
}

sub addMobileQuery
{
    $currentQuery = shift;

    #calculate query overlap
    push(@mobileQueryOverlap, getQueryOverlap($currentQuery));
}

sub processDesktopQuery
{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    if($type == 1)
    {
        addDesktopQuery($currentQuery);
    }
}

sub processMobileQuery
{
    $currentQuery = shift;
    my $type = getQueryType($currentQuery);
    if($type == 1)
    {
        addMobileQuery($currentQuery);
    }
}

sub printResults{
    foreach $mobileOverlap (@mobileQueryOverlap)
    {
        print "$mobileOverlap\n";
    }
    print "desktop\n";
    
    foreach $pcOverlap (@pcQueryOverlap)
    {
        print "$pcOverlap\n";
    }
    
}

sub main {
    while($_ = <STDIN>){
        my @query = split(/>>>/, $_);
        chomp(@query);
        
        if($query[$sessionIdIndex] != $currentSession){
            $currentSession = $query[$sessionIdIndex];
            
            
        } else {
            if($query[$deviceIndex] eq "Desktop"){
                processDesktopQuery(lc($query[$keywordsIndex]));
            } else {
                processMobileQuery(lc($query[$keywordsIndex]));
            }
        }
        $lastQuery = lc($query[$keywordsIndex]);
    }
    
    printResults;
}

main;


