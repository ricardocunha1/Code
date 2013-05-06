#!/usr/bin/perl -w
=comment
Devolve o tipo de dispositivo testado

    "notMobile" - n‹o Ž dispositivo m—vel(desktop) - 0
    "mobile" - dispositivo mobile"tradicional" - 1
    "smartphone" - Android/iPhone/WP/iPod - 2
    "tablet" - iPad - 3
    "blackberry" - 4
    "bot" - 5
    
    
Utiliza regex de "browserRegex.pl"
    
Ricardo Cunha @ 2013
=cut
require "browserRegex.pl";
BEGIN { push @INC, '/Users/ricardocunha/Documents/FEUP/5ano/MSc Thesis/Thesis/Code/Scripts/FilterScripts' }
require "checkBotBrowser.pl";
#iPod fica em que categoria??
use constant {
    NOTMOBILE => 0,
    MOBILE => 1,
    SMARTPHONE => 2,
    TABLET => 3,
    BLACKBERRY => 4,
    BOT => 5
};

use feature qw/switch/; 

sub getDeviceTypeInString{
    my $constant = shift;
    given($constant){
        when(0){return "Desktop"};
        when(1){return "Other Mobile Devices"};
        when(2){return "Smartphone"};
        when(3){return "Tablet"};
        when(4){return "Blackberry"};
        when(5){return "Bot"};
    }
}

sub getDeviceType {
    $browser = shift;
    
    #checking for bots
    if(isBotBrowser($browser)){
        return 5;
    }
    #tablets
    if($browser =~ $browserRegex{ipad} || $browser =~ $browserRegex{androidTablet} ||
       $browser =~ $browserRegex{playbookTablet} || $browser =~ $browserRegex{hpTablet} || $browser =~ $browserRegex{kindle}){
        return 3;
    }
    
    #smartphone - iPod added here for now
    if($browser =~ $browserRegex{androidPhone} || $browser =~ $browserRegex{iphone} || $browser =~ $browserRegex{windowsPhone}
       || $browser =~ $browserRegex{ipod}){
        return 2;
    }
    
    
    
    #Blackberry
    if($browser =~ $browserRegex{blackberry}){
        return 4;
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
       $browser =~ $browserRegex{avantgo} || $browser =~ $browserRegex{palm} || $browser =~ $browserRegex{wap} ||
       $browser =~ $browserRegex{huawei} || $browser =~ $browserRegex{mp} || $browser =~ $browserRegex{psp} ||
       $browser =~ $browserRegex{mobileSafari} || $browser =~ $browserRegex{nintendods}){
        return 1;
        
    }
    
    
    return 0;
    
}

