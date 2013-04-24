#!/usr/bin/perl -w
%hash = ();

sub onList {
    my $browser = shift;
    return exists($hash{$browser});
}

sub addToList {
    my $string = shift;
    if(onList($string)){ # se browser nao esta na lista
        my $counter = $hash{$string};
        $counter++;
        $hash{$string} = $counter;
    } else {
        $hash{$string} = 1;
    }
    #} 
}

sub printList{
    foreach $key (sort{$hash{$a} <=> $hash{$b}} keys %hash){
        print "$key>>>$hash{$key}\n\n";
    }
}

sub main {
    while($string = <STDIN>){
        if($string =~ m/^<keywords>(.*?)<\/keywords>/){
            addToList($1);
        }
    }
    
    printList;
}

main;


