#!/usr/bin/perl -w
=comment
Devolve o tipo de dispositivo testado

    "notMobile" - n‹o Ž dispositivo m—vel
    "mobile" - dispositivo mobile"tradicional"
    "smartphone" - Android/iPhone/WP/iPod
    "tablet" - iPad
    "blackberry"
    
    
Utiliza regex de "browserRegex.pl"
    
Ricardo Cunha @ 2013
=cut
require "browserRegex.pl";
#iPod fica em que categoria??
use constant {
    NOTMOBILE => 0,
    MOBILE => 1,
    SMARTPHONE => 2,
    TABLET => 3,
    BLACKBERRY => 4
};

use feature qw/switch/; 

sub getDeviceTypeInString{
    my $constant = shift;
    given($constant){
        when(NOTMOBILE){return "Not Mobile"};
        when(MOBILE){return "Other Mobile Devices"};
        when(SMARTPHONE){return "Smartphone"};
        when(TABLET){return "Tablet"};
        when(BLACKBERRY){return "Blackberry"};
    }
}

sub getDeviceType {
    $browser = shift;
    
    #checking for bots
    if($browser =~ $browserRegex{bots}){
        return NOTMOBILE;
    }
    
    #smartphone - iPod added here for now
    if($browser =~ $browserRegex{android} || $browser =~ $browserRegex{iphone} || $browser =~ $browserRegex{windowsPhone}
       || $browser =~ $browserRegex{ipod}){
        return SMARTPHONE;
    }
    
    #tablets
    if($browser =~ $browserRegex{ipad}){
        return TABLET;
    }
    
    #Blackberry
    if($browser =~ $browserRegex{blackberry}){
        return BLACKBERRY;
    }
    
    #just mobile
    if($browser =~ $browserRegex{windowsCE} || $browser =~ $browserRegex{alcatel} ||
       $browser =~ $browserRegex{htc} || $browser =~ $browserRegex{lg} || $browser =~ $browserRegex{lge} ||
       $browser =~ $browserRegex{mot} || $browser =~ $browserRegex{vodafone} || $browser =~ $browserRegex{nokia} ||
       $browser =~ $browserRegex{opera} || $browser =~ $browserRegex{windowsMobile} || $browser =~ $browserRegex{sagem} ||
       $browser =~ $browserRegex{samsung} || $browser =~ $browserRegex{sec} || $browser =~ $browserRegex{sgh} ||
       $browser =~ $browserRegex{siemens} || $browser =~ $browserRegex{sonyEricsson} || $browser =~ $browserRegex{teleca} ||
       $browser =~ $browserRegex{toshiba} || $browser =~ $browserRegex{zte} || $browser =~ $browserRegex{siemens} ||
       $browser =~ $browserRegex{symbian} || $browser =~ $browserRegex{webOS} || $browser =~ $browserRegex{bada} ||
       $browser =~ $browserRegex{avantgo} || $browser =~ $browserRegex{palm}){
        return MOBILE;
        
    }
    
    
    return NOTMOBILE;
    
}

