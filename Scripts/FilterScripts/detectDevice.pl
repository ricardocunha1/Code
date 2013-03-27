#!/usr/bin/perl -w
use HTTP::BrowserDetect;

sub main{
    while($_ = <STDIN>){
        if(length($_) > 1){
            @line = split(" - ", $_);
            $user_agent = $line[0];
            $agent = HTTP::BrowserDetect->new($user_agent);
            
           # print $agent->mobile() . "\n";
            if(!$agent->mobile()){
                print "$line[0]\n\n";
            }
            #if(defined $agent->device_name()){
            #    print $agent->device_name() . "\n";
           # }
        }
        
    }
}

main;


