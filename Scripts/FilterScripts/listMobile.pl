#!/usr/bin/perl -w
%hash = ();

sub onList {
    my $browser = shift;
    foreach $key (keys %hash){
        if($key eq $browser){
            return 1;
        }
    }
    
    return 0;
}
use feature qw/switch/;
use HTTP::BrowserDetect;
sub retrieveBrowser{
    $string = shift;
    #print "$string\n";
    $agent = HTTP::BrowserDetect->new($string);
   # $device_name = $agent->device_name();
    if($agent->mobile()){
        return $agent->device_name();
    }
    
}

sub addToList {
    my $string = shift;
    my $browser = retrieveBrowser($string);
    if(defined $browser && $browser ne "") {
        if(onList($browser)){ # se browser ja esta na lista
            $counter = $hash{$browser};
            $counter++;
            $hash{$browser} = $counter;
        } else {
            $hash{$browser} = 1;
        }
    } 
}

sub printList{
    foreach $key (sort{ $hash{$b} <=> $hash{$a} } keys %hash){
        print "$key - $hash{$key}\n";
    }
}

sub main{
    $count = 0;
    while($_ = <STDIN>){
        if($_ =~ m/^<browser/){
            if($_ =~ m/^<browser>(.*)<\/browser>$/){
                addToList($1);
                 
               #print "$1\n";
            }
            $count++;
        }
    }
    print "$count\n";
    printList();
}

main;


