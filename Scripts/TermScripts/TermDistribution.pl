#!/usr/bin/perl -w
#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/TermScripts' }
require "FunctionWords.pl";
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

%termsWFuncWords = ();
%termsWoutFuncWords = ();

$nTermsWFuncWords = 0;
$nTermsWoutFuncWords = 0;
$nUniqueWFuncWords = 0;
$nUniqueWoutFuncWords = 0;

sub addToWFuncWordsHash {
    my $term = shift;
    if(exists($termsWFuncWords{$term})){
        $termsWFuncWords{$term}++;
    } else {
        $termsWFuncWords{$term} = 1;
        $nUniqueWFuncWords++;
    }
    
}

sub addToWoutFuncWordsHash {
    my $term = shift;
    if(exists($termsWoutFuncWords{$term})){
        $termsWoutFuncWords{$term}++;
    } else {
        $termsWoutFuncWords{$term} = 1;
        $nUniqueWoutFuncWords++;
    }
    
}

sub processTerm {
    my $term = shift;
    
    if(!isFunctionWord($term)){
        addToWoutFuncWordsHash($term);
        $nTermsWoutFuncWords++;
    }
    
    addToWFuncWordsHash($term);
    
}

sub printResults {
    print "$nTermsWFuncWords>>>$nUniqueWFuncWords>>>$nTermsWoutFuncWords>>>$nUniqueWoutFuncWords\n";
    foreach $term (sort{ $termsWFuncWords{$b} <=> $termsWFuncWords{$a}} keys %termsWFuncWords){
        print "$term>>>$termsWFuncWords{$term}\n";
    }
    
    print "without\n";
    
    foreach $term (sort{ $termsWoutFuncWords{$b} <=> $termsWoutFuncWords{$a}} keys %termsWoutFuncWords){
        print "$term>>>$termsWoutFuncWords{$term}\n";
    }
}

sub main {
    while($_ = <STDIN>){
        @query = split(/>>>/, $_);
        
        my @terms = split(/\s/,lc($query[$keywordsIndex]));
        
        foreach $term (@terms){
            if($term ne ""){
                processTerm($term);
                $nTermsWFuncWords++;
            }
        }
        
    }
    
    printResults();
}

main;


