#!/usr/bin/perl -w
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/Utils' }
require "checkDeviceType.pl";
#hash que guarda os browsers encontrados
%hash = ();

sub onList {
    my $browser = shift;
    return exists($hash{$browser});
}

#use feature qw/switch/; 

#sub retrieveBrowser{
 #   $string = shift;
  #  given($string){
   #     when($string =~ /Firefox\/([A-Za-z0-9.]+)/i) { return "Firefox";}
    #    when($string =~ /Chrome\/([A-Za-z0-9.]+)/i) { return "Chrome";}
     #   when($string =~ /MSIE ([A-Za-z0-9.]+)/i) { return "Internet Explorer";}
      #  default { return "";}
   # }
#}

sub addToList {
    my $string = shift;
    if($string =~ m/Windows NT/i || $string =~ m/Windows 98/i || $string =~ m/Windows XP/i || $string =~ m/Mac OS X/i){
        if(getDeviceType($string) == 0){
            if(onList($string)){ # se browser nao esta na lista
                my $counter = $hash{$string};
                $counter++;
                $hash{$string} = $counter;
            } else {
                $hash{$string} = 1;
            }
        } 
    }
    #} 
}

sub printList{
    open(FILE, ">PCDataset/allBrowsers.txt");
    $hashLength = scalar(keys %hash);
    print FILE "$hashLength\n";
    foreach $key (sort keys %hash){
        # print to allBrowsers.txt file
        print FILE "$key - $hash{$key}\n\n";
    }
    
    close(FILE);
}

sub main{
    $count = 0;
    while($_ = <STDIN>){
        if($_ =~ m/^<browser/){
            if($_ =~ m/^<browser>(.*?)<\/browser>$/){
                if($1 ne ""){
                    addToList($1);
                }
                 
               #print "$1\n";
            } else{
                addToList("EMPTY");
            }
            $count++;
            print "$count\n";
        }
    }
    printList();
}

main;



