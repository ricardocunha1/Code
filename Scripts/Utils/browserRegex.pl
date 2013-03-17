#!/usr/bin/perl
%browserRegex = (
    
    #bots
    bots => qr/(bot|crawler|crawling|spider|rss)/,
    windowsCE => qr/Windows CE/i,
    alcatel => qr/^Alcatel/i,
    htc => qr/^HTC/i,
    lg => qr/^LG(.*?)MIDP/i,
    lge => qr/^LGE/i,
    mot => qr/^MOT/i,
    vodafone => qr/Vodafone/i,
    nokia => qr/Nokia/i,
    opera => qr/Opera Mini/i,
    windowsMobile => qr/((Windows Mobile) | (WindowsMobile))/i,
    sagem => qr/^SAGEM/i,
    samsung => qr/^Samsung/i,
    sec => qr/^SEC/i,
    sgh => qr/^SGH/i,
    siemens => qr/^SIE/i,
    sonyEricsson => qr/SonyEricsson/i,
    teleca => qr/^TELECA/i,
    toshiba => qr/^Toshiba/i,
    zte => qr/^zte/i,
    
    ipod => qr/\(iPod\;/i,
    iphone => qr/\(iPhone\;/i,
    ipad => qr/\(iPad\;/i,
    android => qr/Android/i,
    symbian => qr/(Symbian | SymbOS)/i,
    webOS => qr/webOS/i,
    windowsPhone => qr/Windows Phone/i,
    bada => qr/Bada/i,
    blackberry => qr/Blackberry/i,
    
    avantgo => qr/AvantGo/i,
    palm => qr/^Palm/i
    
    
);

