# 1. Konfigurasi IP Address (4 Kaki)
/ip address add address=192.168.1.2/24 interface=ether1 comment="WAN - To R1"
/ip address add address=192.168.10.1/30 interface=ether2 comment="ZONE - To R2-Mhs"
/ip address add address=192.168.20.1/30 interface=ether3 comment="ZONE - To R3-Akd"
/ip address add address=192.168.40.1/30 interface=ether4 comment="ZONE - To R4-Adm"

# 2. Routing Default (Ke Internet)
/ip route add gateway=192.168.1.1 comment="Default Route to Internet"

# 3. Routing Statis (Ke Subnet Klien di Bawah Router)
# Ke Mahasiswa & Guest (via R2)
/ip route add dst-address=10.20.10.0/24 gateway=192.168.10.2
/ip route add dst-address=10.20.50.0/24 gateway=192.168.10.2
# Ke Akademik & Riset (via R3)
/ip route add dst-address=10.20.20.0/24 gateway=192.168.20.2
/ip route add dst-address=10.20.30.0/24 gateway=192.168.20.2
# Ke Admin (via R4)
/ip route add dst-address=10.20.40.0/24 gateway=192.168.40.2

# 4. NAT (Agar semua klien bisa internetan)
/ip firewall nat add chain=srcnat out-interface=ether1 action=masquerade comment="NAT Masquerade"

# 5. Firewall Filter (Izinkan semua dulu untuk tes ping)
/ip firewall filter add chain=forward action=accept comment="Allow All Init"


# Memastikan Konfigurasi Sudah Masuk
/ip address print