create_zone() {
    local zonename=$1
    iptables -N Zone${zonename}Input
    iptables -N Zone${zonename}Forward
    iptables -t nat -N Zone${zonename}Postrouting
}

add_to_zone() {
    local zonename=$1; shift
    local iface=
    for iface in $@; do
        iptables -A INPUT -i $iface -j Zone${zonename}Input
        iptables -A FORWARD -i $iface -j Zone${zonename}Forward
        iptables -t nat -A POSTROUTING -o $iface -j Zone${zonename}Postrouting
    done
}

setup_nat_chains() {
    while read table builtin_chain user_chain; do
        if iptables -t $table -n --list "$user_chain" >/dev/null 2>&1; then
            iptables -t $table -F $user_chain
            iptables -t $table -D $builtin_chain -j $user_chain >/dev/null 2>&1 || :
            iptables -t $table -X $user_chain
        fi
        iptables -t $table -N $user_chain
        iptables -t $table -A $builtin_chain -j $user_chain
    done <<EOF
filter FORWARD     PortmapFilterForward
nat    PREROUTING  PortmapNatPrerouting
nat    POSTROUTING PortmapNatPostrouting
EOF
}

dnat() {
    local waniface=$1
    local wanaddr=$2
    local lanaddr=$3
    [[ -z "$waniface" || -z "$wanaddr" || -z "$lanaddr" ]] && return
    iptables -A PortmapFilterForward -i "$waniface" -d $lanaddr -j ACCEPT
    iptables -t nat -A PortmapNatPrerouting -d $wanaddr -j DNAT --to-destination $lanaddr
}

snat() {
    local waniface=$1
    local lanaddr=$2
    local wanaddr=$3
    [[ -z "$waniface" || -z "$wanaddr" || -z "$lanaddr" ]] && return
    iptables -t nat -A PortmapNatPostrouting -o "$waniface" -s $lanaddr -j SNAT --to-source $wanaddr
}

o2onat() {
    # 1:1映射，我们在后面会讨论
    local waniface=$1
    local wanaddr=$2
    local lanaddr=$3
    dnat $waniface $wanaddr $lanaddr
    snat $waniface $lanaddr $wanaddr
}

portmap() {
    # 端口映射，其实就是dnat()，不过仅用于TCP/UDP协议，因为其他协议可能没有端口的概念
    local waniface=$1
    local wanaddr=$2
    local wanport=$3
    local lanaddr=$4
    local lanport=$5
    [[ -z "$waniface" || -z "$wanaddr" || -z "$wanport" || -z "$lanaddr" || -z "$lanport" ]] && return
    iptables -A PortmapFilterForward -i "$waniface" -d $lanaddr -p tcp --dport "$lanport" -j ACCEPT
    iptables -A PortmapFilterForward -i "$waniface" -d $lanaddr -p udp --dport "$lanport" -j ACCEPT
    iptables -t nat -A PortmapNatPrerouting -d $wanaddr -p tcp --dport $wanport -j DNAT --to $lanaddr:$lanport
    iptables -t nat -A PortmapNatPrerouting -d $wanaddr -p udp --dport $wanport -j DNAT --to $lanaddr:$lanport
}

alias ip6="ip -6"
