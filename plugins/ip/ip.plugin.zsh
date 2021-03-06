function ipip(){
    curl http://freeapi.ipip.net/$1
}
function ipsb(){
    if `type jq >/dev/null 2>&1`; then
        curl -sS https://api.ip.sb/geoip/$1 | jq
    else
        curl -sS https://api.ip.sb/geoip/$1
    fi
}
function myip(){
    curl http://ifconfig.io
}

function dec2ip () {
    local ip delim dec=$@
    for e in {3..0}
    do
        ((octet = dec / (256 ** e) ))
        ((dec -= octet * 256 ** e))
        ip+=$delim$octet
        delim=.
    done
    echo "$ip"
}

function ip2dec () {
    local a b c d ip=$@
    IFS=. read -r a b c d <<< "$ip"
    echo "$((a * 256 ** 3 + b * 256 ** 2 + c * 256 + d))"
}
