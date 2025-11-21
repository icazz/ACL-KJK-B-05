# --- Konfigurasi R1 ---

auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
    address 192.168.1.1
    netmask 255.255.255.0
    post-up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    post-up sysctl -w net.ipv4.ip_forward=1
    
    # Routing Balik:
    # Beritahu R1 bahwa semua traffic menuju 10.20.x.x ada di belakang Firewall (192.168.1.2)
    up route add -net 10.20.0.0 netmask 255.255.0.0 gw 192.168.1.2
    
    # Opsional: Jika Anda ingin R1 bisa ping IP WAN Router (192.168.10.x s/d 50.x)
    # up route add -net 192.168.0.0 netmask 255.255.0.0 gw 192.168.1.2