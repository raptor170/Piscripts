#!bin/sh

echo "
    ____        __    _
   / __ \____  / /_  (_)___  _________  ____      
  / /_/ / __ \/ __ \/ / __ \/ ___/ __ \/ __ \     
 / _, _/ /_/ / /_/ / / / / (__  ) /_/ / / / /     
/_/ |_|\____/_.___/_/_/ /_/____/\____/_/ /_/      
   _______________(_)___  / /______
  / ___/ ___/ ___/ / __ \/ __/ ___/
 (__  ) /__/ /  / / /_/ / /_(__  )
/____/\___/_/  /_/ .___/\__/____/
                /_/
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⠀⠀⢀⡄⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠐⣦⣸⣿⣷⣴⣿⣷⣠⣾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣤⣤⣽⡟⢀⣀⣀⣀⠸⣿⣧⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠉⠛⠁⠘⠛⠛⠛⠀⠙⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠛⠀⠀⠛⠛⣿⣿⠀⣿⣿⡄⠰⢶⣤⡀⠀⠀⠀
⠀⢸⣿⡿⠉⢿⣿⣿⣿⣿⣿⣄⣀⠀⠀⣀⣀⣿⣿⠀⣿⣿⣇⠀⠀⠈⠻⣦⠀⠀
⠀⢸⣿⠇⣀⠘⣿⣿⣿⣿⣿⣿⣿⣤⣤⣿⣿⣿⣿⠀⣿⣿⣿⣀⣀⣀⣀⣈⡀⠀
⠀⠘⠋⢠⣿⡄⠹⠋⣀⣀⣀⣀⣀⣀⣀⣀⣀⣈⣿⠀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀
⠀⢰⣶⡾⠛⠁⠀⠚⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⣀⡀⠀⠀⠀⠀⢀⣀⡀⠀
⠀⠘⠛⠁⣾⣿⣿⣦⠈⠛⠛⠛⠛⠛⠛⠛⠛⠛⠛⠀⠙⠁⣴⣿⣿⣷⠈⠛⠃⠀
⠀⠀⠀⠀⠙⠻⠟⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⠟⠋⠀⠀⠀⠀

SAVING YOUR TIME ONE SCRIPT AT A TIME"

#sleep will pause to progress to next line and is in seconds
sleep 2
    echo ""
    echo "Unbound Automatic Installation Script"
sleep 0.5
#echo and using the parentheses will print the text
    echo ""
    echo "Scripting first aid will start in"
    echo ""
sleep 1
    echo "3"
sleep 1
    echo "2"
sleep 1
    echo "1"
sleep 1

sudo apt update && sudo apt upgrade -y
if [ -f /usr/sbin/unbound ]
then
    echo "Unbound is already installed"
    echo "ENJOY USING UNBOUND"
exit 99
else
    echo "Unbound not installed, Preparing your installation"⠀⠀⠀⠀
fi
sudo apt install unbound -y
sudo touch /etc/unbound/unbound.conf.d/pi-hole.conf
sudo sh -c 'cat > /etc/unbound/unbound.conf.d/pi-hole.conf' << EOF
server:
    # If no logfile is specified, syslog is used
    # logfile: "/var/log/unbound/unbound.log"
    verbosity: 0

    interface: 127.0.0.1
    port: 5335
    do-ip4: yes
    do-udp: yes
    do-tcp: yes

    # May be set to yes if you have IPv6 connectivity
    do-ip6: no

    # You want to leave this to no unless you have *native* IPv6. With 6to4 and
    # Terredo tunnels your web browser should favor IPv4 for the same reasons
    prefer-ip6: no

    # Use this only when you downloaded the list of primary root servers!
    # If you use the default dns-root-data package, unbound will find it automatically
    #root-hints: "/var/lib/unbound/root.hints"

    # Trust glue only if it is within the server's authority
    harden-glue: yes

    # Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes BOGUS
    harden-dnssec-stripped: yes

    # Don't use Capitalization randomization as it known to cause DNSSEC issues sometimes
    # see https://discourse.pi-hole.net/t/unbound-stubby-or-dnscrypt-proxy/9378 for further details
    use-caps-for-id: no

    # Reduce EDNS reassembly buffer size.
    # IP fragmentation is unreliable on the Internet today, and can cause
    # transmission failures when large DNS messages are sent via UDP. Even
    # when fragmentation does work, it may not be secure; it is theoretically
    # possible to spoof parts of a fragmented DNS message, without easy
    # detection at the receiving end. Recently, there was an excellent study
    # >>> Defragmenting DNS - Determining the optimal maximum UDP response size for DNS <<<
    # by Axel Koolhaas, and Tjeerd Slokker (https://indico.dns-oarc.net/event/36/contributions/776/)
    # in collaboration with NLnet Labs explored DNS using real world data from the
    # the RIPE Atlas probes and the researchers suggested different values for
    # IPv4 and IPv6 and in different scenarios. They advise that servers should
    # be configured to limit DNS messages sent over UDP to a size that will not
    # trigger fragmentation on typical network links. DNS servers can switch
    # from UDP to TCP when a DNS response is too big to fit in this limited
    # buffer size. This value has also been suggested in DNS Flag Day 2020.
    edns-buffer-size: 1232

    # Perform prefetching of close to expired message cache entries
    # This only applies to domains that have been frequently queried
    prefetch: yes

    # One thread should be sufficient, can be increased on beefy machines. In reality for most users running on small networks or on a single machine, it should be unnecessary to seek performance enhancement by increasing num-threads above 1.
    num-threads: 1

    # Ensure kernel buffer is large enough to not lose messages in traffic spikes
    so-rcvbuf: 1m

    # Ensure privacy of local IP ranges
    private-address: 192.168.0.0/16
    private-address: 169.254.0.0/16
    private-address: 172.16.0.0/12
    private-address: 10.0.0.0/8
    private-address: fd00::/8
    private-address: fe80::/10
EOF

if [ -f /etc/unbound/unbound.conf.d/pi-hole.conf ]
then
    echo "/etc/unbound/unbound.conf.d/pi-hole.conf has been created and updated"
else
    echo "/etc/unbound/unbound.conf.d/pi-hole.conf has failed to be created, uninstalling unbound, please try again"
sudo apt remove unbound -y
exit 98
fi
sudo touch /etc/dnsmasq.d/99-edns.conf
sudo sh -c 'cat > /etc/dnsmasq.d/99-edns.conf' << EOF
edns-packet-max=1232
EOF

if [ -f /etc/dnsmasq.d/99-edns.conf ]
then
    echo "/etc/dnsmasq.d/99-edns.conf created and updated"
else
    echo "/etc/dnsmasq.d/99-edns.conf has failed to be created, uninstalling unbound, please try again"
sudo apt remove unbound -y
exit 97
fi

sudo systemctl disable --now unbound-resolvconf.service

sudo sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolvconf.conf
sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf
sudo service unbound restart
sudo systemctl restart unbound
    echo "Unbound Restarting, please wait....May take a bit of time"
sleep 30
    echo ""
    echo ""
    echo ""
    echo "Check few lines down and make sure Status says NOERROR"
    echo ""
dig dnssec.works @127.0.0.1 -p 5335
    echo ""
    echo ""
    echo ""
sleep 5
    echo "Check few lines down and make sure status says SERVFAIL"
    echo ""
dig fail01.dnssec.works @127.0.0.1 -p 5335
sleep 2
dig fail01.dnssec.works @127.0.0.1 -p 5335
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
sleep 5
    echo "If dig dnssec.works @127.0.0.1 -p 5335 shows NOERROR"
    echo "And dig fail01.dnssec.works @127.0.0.1 -p 5335 Shows SERVFAIL"
    echo ""
    echo ""
    echo "Than Proceed to Pihole, Settings, DNS, under Custom 1 IPv4 enter the value"
    echo "127.0.0.1#5335"
    echo "and click save on bottom of page"
    echo ""
    echo "If all goes well, Enjoy Running Unbound!!!"
    echo "and if feeling generous, im always down for a coffee, donations not required, but appreciated"
    echo "Thank you for using Robinson Scripts, ENJOY!!!"
