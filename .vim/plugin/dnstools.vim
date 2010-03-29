" DNS Serial Incrementer
" Author: Folke Ashberg <folke@ashberg.de>
" Copyright: 2001 by Folke Ashberg
" LAST MODIFICATION: Fre Sep 14 19:05:32 CEST 2001
" CVS: $Id: dnstools.vim,v 1.4 2002/08/15 11:08:15 folke Exp $
" Usage:
"         Serial Updater:
"         Just execute the command DNSserial and this tiny script
"         will increment the serial number, preserving that style you use :)



function DNS_getnum(oldnum)
    let oldnum = a:oldnum
    if oldnum < 19700101
        " 1, 2, 3 style
        let retval = oldnum + 1
    elseif oldnum < 1970010100
        " YYYYMMDD style
        let dateser = strftime("%Y%m%d")
        if dateser > oldnum
            let retval = dateser
        else
            let retval = oldnum + 1
        endif
    else
        " YYYYMMDDNN style
        let dateser = strftime("%Y%m%d00")
        if dateser > oldnum
            let retval = dateser
        else
            let retval = oldnum + 1
        endif
    endif
    return retval
endfun

function DNSserial()
    let restore_position_excmd = line('.').'normal! '.virtcol('.').'|'
    let oldignorecase = &ignorecase
    set ignorecase
    " substitute now ( there's a bug in VIM's vi Syntax :(   )
    " silent
    %s/\(soa[[:space:]]\+[a-z0-9.-]\+[[:space:]]\+[a-z0-9.-]\+[[:space:]]*(\?[\n\t ]*\)\([0-9]\+\)/\=submatch(1) . DNS_getnum( submatch(2) )/
    " restore position 
    exe restore_position_excmd
    " disable hls
    if 1 == &hls
        noh
    else
        set hls
    endif
    " restore old case behave
    let &ignorecase=oldignorecase
endfun

command DNSserial :call DNSserial()




function DNSzone()
    let zone = input("Name der Zone: ")
    let ip   = input("IP: " , "62.26.219.121")
    let ins=""
    let ins = ins . "$INCLUDE /var/named/ttl-file\n"
    let ins = ins . ";       File: \"" . zone . ".dom\"\n"
    let ins = ins . ";       FQDN: \"" . zone . "\"\n"
    let ins = ins . "@       IN SOA ns1.dns-zone.net. hostmaster.dns-zone.net. (\n"
    let ins = ins . "                " . strftime("%Y%m%d00") . "; serial number\n"
    let ins = ins . "                3H              ; refresh\n"
    let ins = ins . "                1H              ; retry\n"
    let ins = ins . "                1W              ; expiry\n"
    let ins = ins . "                1D )            ; minimum\n"
    let ins = ins . "\n"
    let ins = ins . ";        Zone NS records\n"
    let ins = ins . "\n"
    let ins = ins . "@                               IN      NS      ns1.dns-zone.net.\n"
    let ins = ins . "@                               IN      NS      ns2.dns-zone.net.\n"
    let ins = ins . "\n"
    let ins = ins . ";        Zone MX records\n"
    let ins = ins . "\n"
    let ins = ins . "@                               IN      MX      30      mail\n"
    let ins = ins . "@                               IN      MX      60      mail3.iok.net.\n"
    let ins = ins . "@                               IN      MX      90      mail3.csl-gmbh.net.\n"
    let ins = ins . "\n"
    let ins = ins . ";        Zone records\n"
    let ins = ins . "\n"
    let ins = ins . "                                IN      A       " . ip ."\n"
    let ins = ins . "www                             IN      CNAME   " . zone . ".\n"
    let ins = ins . "ftp                             IN      CNAME   " . zone . ".\n"
    let ins = ins . "smtp                            IN      CNAME   " . zone . ".\n"
    let ins = ins . "\n"
    put!=ins
endfun
