#!/usr/bin/perl -w

sub isBotBrowser{
    $browser = shift;
    if($browser =~/bot/i || $browser =~ /feed/i || $browser =~ /rss/i || $browser =~ /^sapo/i || $browser =~/crawler/i ||
       $browser =~/spider/i || $browser =~/tracker/i || $browser =~ /AHTTPConnection/i || $browser =~ /Activeworlds/i || $browser =~ /360se/i ||
       $browser =~ /UnChaos/i || $browser =~ /AdminSecure/i || $browser =~ /^CFNetwork/i ||
       $browser =~ /^Adobe/i || $browser =~ /Advanced URL Catalog/i || $browser =~ /Akregator/i ||
       $browser =~ /^Aggregator/i || $browser =~ /^AngryBirds/i || $browser =~ /Apache-HttpClient/i ||
       $browser =~ /AppEngine-Google/i || $browser =~ /AppleSyndication/i || $browser =~ /ArbeFavIcons/i ||
       $browser =~ /HttpClient/i || $browser =~ /^AutoIt/i || $browser =~ /AzBUL.NET/i ||
       $browser =~ /Apple-Pubsub/i || $browser =~ /AppleSyndication/i || $browser =~ /bloglines/i || $browser =~ /^BoardReader/i ||
       $browser =~ /^CSE HTML Validator Online/i || $browser =~ /curl/i || $browser =~ /^CheckUrl/i || $browser =~ /^CitiStreet.com/i ||
       $browser =~ /^Claymont.com/i || $browser =~ /Contacts/i || $browser =~ /^Crowsnest/i || $browser =~ /^DoCoMo/i || $browser =~ /^FDM/i || $browser =~ /FLUX-Toolchain/i ||
       $browser =~ /^FreeWebMonitoring/i || $browser =~ /^GStreamer/i || $browser =~ /greatnews/i || $browser =~ /HTTP_Request/i || $browser =~ /^Hatena/i || $browser =~ /HoundDog/i ||
       $browser =~ /IlTrovatore/i || $browser =~ /InetURL/i || $browser =~ /Infoseek/i || $browser =~ /JS-Kit/i || $browser =~ /Jakarta/i || $browser =~ /^Java/i || $browser =~ /^PHP/i ||
       $browser =~ /JetBrains/i || $browser =~ /^Jigsaw/i || $browser =~ /Kaspersky/i || $browser =~ /^LWP::Simple/i || $browser =~ /Liferea/i || $browser =~ /LinkExaminer/i || $browser =~ /^Lynx/i ||
       $browser =~ /^MacKeeper/i || $browser =~ /McAfee/i || $browser =~ /MetaURI/i || $browser =~ /Microsoft BITS/i || $browser =~ /Microsoft URL/i || $browser =~ /Microsoft Windows Network Diagnostics/i || $browser =~ /Microsoft-CryptoAPI/i ||
       $browser =~ /Microsoft-WebDAV-MiniRedir/i || $browser =~ /Morfeus/i || $browser =~ /Winhttp/i || $browser =~ /T-H-U-N-D-E-R-S-T-O-N-E/i ||
       $browser =~ /yahoo/i || $browser =~ /reader/i || $browser =~ /masking-agent/i || $browser =~ /validator/i || $browser =~ /^MyApp/i || $browser =~ /^NING/i || $browser =~ /NP_Referrer/i ||
       $browser =~ /NSPlayer/i || $browser =~ /NewsGatorOnline/i || $browser =~ /POE-Component-Client-HTTP/i || $browser =~ /plagger/i || $browser =~ /PubSubAgent/i || $browser =~ /PuxaRapido/i || $browser =~ /python/i ||
       $browser =~ /Referrer Karma/i || $browser =~ /RiverglassScanner/ || $browser =~ /Ruby/ || $browser =~ /SOAP/ || $browser =~ /SearchBlox/ || $browser =~ /SiteTruth.com/ ||
       $browser =~ /^Snoopy/ || $browser =~ /SocialPushAgent/ || $browser =~ /^Sphider/ || $browser =~ /System.Net.AutoWebProxyScriptEngine/ || $browser =~ /TencentTraveler/ || $browser =~ /TipTop/ || $browser =~ /TulipChain/i ||
       $browser =~ /^UNTRUSTED/ || $browser =~ /User-agent/i || $browser =~ /Utopia WebWasher/ || $browser =~ /VB Project/i || $browser =~ /WLUploader/ || $browser =~ /WWW-Mechanize/ || $browser =~ /Web Downloader/ ||
       $browser =~ /WebCopier/i || $browser =~ /WebProcess/i || $browser =~ /Website Explorer/i || $browser =~ /Wget/i || $browser =~ /WinHttp/i || $browser =~ /^Windows-Media-Player/i || $browser =~ /WordPress/i ||
       $browser =~ /^WorldWideweb/i || $browser =~ /^Xenu Link/i || $browser =~ /Y!TunnelPro/i || $browser =~ /YandexSomething/i || $browser =~ /Zend/i || $browser =~ /ZmEu/i || $browser =~ /check-http/i ||
       $browser =~ /aol\/http/i || $browser =~ /facebookexternalhit/i || $browser =~ /OutlookConnector/i || $browser =~ /http_requester/i || $browser =~ /httpunit/i || $browser =~ /iTunes/i || $browser =~ /iPhoto/i ||
       $browser =~ /^libwww-perl/i || $browser =~ /ia_archiver/i || $browser =~ /^integrity/i || $browser =~ /linkdex.com/i || $browser =~ /panscient.com/i || $browser =~ /ping.blo.gs/i || $browser =~ /utorrent/i ||
       $browser =~ /Azureus/i || $browser =~ /autoproxy/i || $browser =~ /^Microsoft Office/i || $browser =~ /^Mozilla\/4.0$/i || $browser =~ /^Mozilla\/5.0$/i || $browser =~ /anonym/i || $browser =~ /Yandex/i || $browser =~ /silk/i
       ){
        return 1;
    }
    
    return 0;
}

1;


