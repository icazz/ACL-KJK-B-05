# --- IP Address ---
auto eth0
iface eth0 inet static
	address 192.168.1.2
	netmask 255.255.255.0
	gateway 192.168.1.1
	post-up sysctl -w net.ipv4.ip_forward=1
	up echo nameserver 8.8.8.8 > /etc/resolv.conf

auto eth1
iface eth1 inet static
	address 192.168.10.1
	netmask 255.255.255.252

auto eth2
iface eth2 inet static
	address 192.168.20.1
	netmask 255.255.255.252

auto eth3
iface eth3 inet static
	address 192.168.40.1
	netmask 255.255.255.252

auto eth4
iface eth4 inet static
	address 192.168.30.1
	netmask 255.255.255.252

auto eth5
iface eth5 inet static
	address 192.168.50.1
	netmask 255.255.255.252

# Routing ke LAN Mahasiswa via R2
route add -net 10.20.10.0 netmask 255.255.255.0 gw 192.168.10.2

# Routing ke LAN Akademik via R3
route add -net 10.20.20.0 netmask 255.255.255.0 gw 192.168.20.2

# Routing ke LAN Admin via R4
route add -net 10.20.40.0 netmask 255.255.255.0 gw 192.168.40.2

# Routing ke LAN Riset via R5
route add -net 10.20.30.0 netmask 255.255.255.0 gw 192.168.30.2

# Routing ke LAN Guest via R6
route add -net 10.20.50.0 netmask 255.255.255.0 gw 192.168.50.2