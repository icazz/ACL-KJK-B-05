# Login ke konsol MikroTik: admin / (kosong)

# ===== 1. Konfigurasi IP Address (4 Lengan) =====
/ip address add address=192.168.1.2/24 interface=ether1 comment="WAN - To R1"
/ip address add address=192.168.10.1/30 interface=ether2 comment="ZONE - To R2-Mhs"
/ip address add address=192.168.20.1/30 interface=ether3 comment="ZONE - To R3-Akd"
/ip address add address=192.168.40.1/30 interface=ether4 comment="ZONE - To R4-Adm"


# ===== 2. Konfigurasi Default Route =====
/ip route add gateway=192.168.1.1 comment="Route to Internet via R1"


# ===== 3. Konfigurasi Firewall NAT (Internal ke Internet) =====
/ip firewall nat add chain=srcnat out-interface=ether1 action=masquerade comment="NAT for all client zones"


# ===== 4. Konfigurasi Firewall Filter (IZINKAN SEMENTARA) =====
# Izinkan semua trafik forward dulu untuk menguji routing
/ip firewall filter add chain=forward action=accept comment="Allow All for Initial Routing Test"

# Login ke konsol MikroTik: admin / (kosong)

# Routing ke Mahasiswa (10.20.10.0/24) dan Guest (10.20.50.0/24) via R2
/ip route add dst-address=10.20.10.0/24 gateway=192.168.10.2 comment="Route Mhs via R2"
/ip route add dst-address=10.20.50.0/24 gateway=192.168.10.2 comment="Route Guest via R2"

# Routing ke Akademik (10.20.20.0/24) dan Riset (10.20.30.0/24) via R3
/ip route add dst-address=10.20.20.0/24 gateway=192.168.20.2 comment="Route Akd via R3"
/ip route add dst-address=10.20.30.0/24 gateway=192.168.20.2 comment="Route Riset via R3"

# Routing ke Admin (10.20.40.0/24) via R4
/ip route add dst-address=10.20.40.0/24 gateway=192.168.40.2 comment="Route Admin via R4"