#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/FilterScripts' }
require "checkBotBrowser.pl";

sub main{
    open(FILE, ">MobileDataset/allMobilev2.txt");
    while($line = <STDIN>){
        #check for PC browsers
        if($line !~ m/Windows NT/i && $line !~ m/Windows 98/i && $line !~ m/Windows XP/i){
            if($line ne "\n"){
                #check for BOT browsers
                if(!isBotBrowser($line)){
                    print FILE "$line\n";
                }
            }
        }
    }
    close FILE;
}

main;


