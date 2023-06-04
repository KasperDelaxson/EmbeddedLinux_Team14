#!/sbin/nft -f
define WAN0 = eth0 # replace by your network device name
flush ruleset
table ip nat {
        chain prerouting {
                type nat hook prerouting priority 0; policy accept;
        }
        # for all packets to WAN, after routing, replace source address with primary IP of WAN interface
        chain postrouting {
                type nat hook postrouting priority 100; policy accept;
                oifname $WAN0 masquerade
        }
}

table inet filter {
        chain input {
                type filter hook input priority 0; policy drop;

                ct state {established, related} accept;

                tcp dport 22 accept;

                tcp dport 80 accept;
        }
}
