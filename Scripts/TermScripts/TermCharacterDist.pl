#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/TermScripts' }
require "FunctionWords.pl";
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";
use DB_File;
%termsWFuncWords = ();
tie(%termsWFuncWords, 'DB_File', "withchar.dbfile", $DB_BTREE);
%termsWoutFuncWords = ();
tie(%termsWoutFuncWords, 'DB_File', "woutchar.dbfile", $DB_BTREE);

sub addToWFuncWordsHash {
    my $length = shift;
    if(exists($termsWFuncWords{$length})){
        $termsWFuncWords{$length}++;
    } else {
        $termsWFuncWords{$length} = 1
    }
    
}

sub addToWoutFuncWordsHash {
    my $length = shift;
    if(exists($termsWoutFuncWords{$length})){
        $termsWoutFuncWords{$length}++;
    } else {
        $termsWoutFuncWords{$length} = 1;
    }
    
}

sub processTerm {
    my $term = shift;
    my $termLength = length($term);
    
    if(!isFunctionWord($term)){
        addToWoutFuncWordsHash($termLength);
    }
    
    addToWFuncWordsHash($termLength);
    
}

sub printResults {
    foreach $charLength (sort{ $a <=> $b} keys %termsWFuncWords){
        print "$charLength>>>$termsWFuncWords{$charLength}\n";
    }
    
    print "without\n";
    
    foreach $charLength (sort{ $a <=> $b} keys %termsWoutFuncWords){
        print "$charLength>>>$termsWoutFuncWords{$charLength}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        my @terms = split(/\s/,lc($query[$keywordsIndex]));
        
        foreach $term (@terms){
            if($term ne ""){
                processTerm($term);
            }
        }
        
    }
    
    printResults();
}

main;
untie(%termsWoutFuncWords);
untie(%termsWFuncWords);


