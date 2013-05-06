#!/usr/bin/perl
%browserRegex = (
    
    windowsCE => qr/Windows CE/i,
    alcatel => qr/^Alcatel/i,
    htc => qr/^HTC/i,
    lg => qr/(^LG)|(LG-([a-zA-Z0-9]*))/i,
    lge => qr/^LGE/i,
    mot => qr/^MOT/i,
    vodafone => qr/Vodafone/i,
    nokia => qr/Nokia/i,
    opera => qr/(Opera Mini)|(Opera Mobi)/i,
    windowsMobile => qr/((Windows Mobile)|(WindowsMobile))/i,
    huawei => qr/^Huawei/i,
    sagem => qr/^SAGEM/i,
    samsung => qr/^Samsung/i,
    sec => qr/^SEC/i,
    sgh => qr/^SGH/i,
    siemens => qr/^SIE/i,
    sonyEricsson => qr/SonyEricsson/i,
    teleca => qr/^TELECA/i,
    toshiba => qr/^Toshiba/i,
    zte => qr/(^zte)|(zte-)/i,
    wap => qr/wap/i,
    mp => qr/MobilePhone/i,
    psp => qr/PSP/i,
    mobileSafari => qr/Mobile Safari/i,
    nintendods => qr/Nintendo 3DS/i,
    psvita => qr/PlayStation Vita/i,
    
    ipod => qr/iPod/i,
    iphone => qr/iPhone/i,
    androidPhone => qr/Android/i,
    symbian => qr/(Symbian|SymbOS|SymbianOS)/i,
    webOS => qr/webOS/i,
    windowsPhone => qr/Windows Phone/i,
    bada => qr/Bada/i,
    blackberry => qr/Blackberry/i,
    
    
    ipad => qr/iPad/i,
    androidTablet => qr/Android(.*?)Tablet/i,
    playbookTablet => qr/PlayBook(.*?)Tablet/i,
    hpTablet => qr/hp-tablet/i,
    kindle => qr/Kindle/i,
    WPtouch => qr/^Mozilla(.*?)Touch/i,
    
    avantgo => qr/AvantGo/i,
    palm => qr/^Palm/i
    
    
);

