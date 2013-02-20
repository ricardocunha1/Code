#!/usr/bin/perl -w

#hash que guarda os browsers encontrados
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

sub retrieveBrowser{
    $string = shift;
    given($string){
        when($string =~ /Firefox\/([A-Za-z0-9.]+)/i) { return "Firefox";}
        when($string =~ /Chrome\/([A-Za-z0-9.]+)/i) { return "Chrome";}
        when($string =~ /MSIE ([A-Za-z0-9.]+)/i) { return "Internet Explorer";}
        default { return "";}
    }
}

sub addToList {
    my $string = shift;
    #$browser = retrieveBrowser($string);
    if($browser ne "") {
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
    print scalar(keys %hash) . "\n";
    foreach $key (sort{ $hash{$b} <=> $hash{$a} } keys %hash){
        print "$key - $hash{$key}\n";
    }
}

sub main{
    $count = 0;
    while($_ = <STDIN>){
        if($_ =~ m/^<browser/){
            if($_ =~ m/^<browser>(.*?)<\/browser>$/){
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

