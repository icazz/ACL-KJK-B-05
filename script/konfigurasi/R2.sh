# Ke Firewall (Uplink)
auto eth0
iface eth0 inet static
    address 192.168.10.2
    netmask 255.255.255.252
    gateway 192.168.10.1
    post-up sysctl -w net.ipv4.ip_forward=1
    up echo nameserver 8.8.8.8 > /etc/resolv.conf

# Ke Switch Mhs (LAN)
auto eth1
iface eth1 inet static
    address 10.20.10.1
    netmask 255.255.255.0