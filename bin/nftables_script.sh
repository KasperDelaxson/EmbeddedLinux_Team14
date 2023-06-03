define WAN0 = eth0 
flush ruleset
table ip nat {
        chain prerouting {
                type nat hook prerouting priority 0; policy accept;
        }
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
