#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "sessionFileIndexes.pl";

@queries = ();

%ordered = ();
$limit = 500;

sub addToHash {
    $query = shift;
    if(exists($ordered{$query})){
        $ordered{$query}++;
    } else {
        $ordered{$query} = 1;
    }
}

sub main {

    while($_ = <STDIN>){
        chop($_);
      #  @query = split(/>>>/, $_);
     #   push(@queries, $query[$keywordsIndex]);
    #    print "$query[$keywordsIndex]\n";
 #   }
    
 #   $counter=0;
    
  #  while($counter < $limit){
        #random number
     #   $randN = int(rand(scalar(@queries)));
       # $output = "$queries[$randN]";
       # print FILE $output;
       # addToHash($output);
        
  #      $counter++;
    
        addToHash($_);
    }

    
    open(FILE, ">CellphoneDataset/orderedRandomQueries.txt");
    
    foreach $key (sort{$ordered{$b} <=> $ordered{$a}} keys %ordered){
        print FILE "$key - $ordered{$key}\n";
    }
    
    close(FILE);
    
    
}

main;




