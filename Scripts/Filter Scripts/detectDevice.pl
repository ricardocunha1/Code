#!/usr/bin/perl -w
use HTTP::BrowserDetect;

sub main{
    $user_agent = "SEC-SGHC506/1.0 Openwave/6.2.3 Profile/MIDP-2.0 Configuration/CLDC-1.1 UP.Browser/6.2.3.3.c.1.101 (GUI) MMP/2.0";
    $agent = HTTP::BrowserDetect->new($user_agent);
    
    print $agent->mobile() . "\n";
    if(defined $agent->device_name()){
        print $agent->device_name() . "\n";
    }
}

main;


