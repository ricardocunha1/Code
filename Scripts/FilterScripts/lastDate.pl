#!/usr/bin/perl -w
$lastDate = 0;
while($_ = <STDIN>){
    if($_ =~ m/^<date>(.*?)<\/date>$/){
        $lastDate = $1;
    }
}

print "$lastDate\n";


