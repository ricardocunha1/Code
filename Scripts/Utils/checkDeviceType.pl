#!/usr/bin/perl -w
=comment
Devolve o tipo de dispositivo testado

    "notMobile" - n‹o Ž dispositivo m—vel
    "mobile" - dispositivo mobile"tradicional"
    "iPhone" - iPhone
    "iPod" - iPod
    "Android" - Android
    "WP" - Windows Phone
    "iPad" - iPad
    "BB" - Blackberry
    
    
Utiliza regex de "browserRegex.pl"
    
Ricardo Cunha @ 2013
=cut
require "browserRegex.pl";
use constant {
    NOTMOBILE => 0,
    MOBILE => 1,
    IPHONE => 2,
    ANDROID => 3,
    IPAD => 4,
    IPOD => 5,
    WP => 6,
    BLACKBERRY => 7
};

sub getDeviceType {
    $browser = shift;
    
    #checking for bots
    if($browser =~ $browserRegex{bots}){
        return NOTMOBILE;
    }
    #android
    if($browser =~ $browserRegex{android}){
        return ANDROID;
    }
    #iPhone
    if($browser =~ $browserRegex{iphone}){
        return IPHONE;
    }
    
    #iPod
    if($browser =~ $browserRegex{ipod}){
        return IPOD;
    }
    
    #iPad
    if($browser =~ $browserRegex{ipad}){
        return IPAD;
    }
    
    #Windows Phone
    if($browser =~ $browserRegex{windowsPhone}){
        return WP;
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

