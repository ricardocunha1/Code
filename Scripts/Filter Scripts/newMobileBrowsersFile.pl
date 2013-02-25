#!/usr/bin/perl -w


sub main{
    open(FILE, ">allMobilev2.txt");
    while($line = <STDIN>){
        if($line !~ m/Windows NT/i && $line !~ m/Windows 98/i && $line !~ m/Windows XP/i){
            if($line ne "\n"){
                print FILE "$line\n";
            }
        }
    }
    close FILE;
}

main;


