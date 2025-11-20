enable
configure terminal
hostname R2

! --- 1. Jalur ke MikroTik ---
interface Ethernet0/0
 description KE-MIKROTIK
 ip address 192.168.10.2 255.255.255.252
 no shutdown
exit

! --- 2. Jalur ke Switch MAHASISWA (Fisik) ---
interface Ethernet1/0
 description JALUR-MHS-FISIK
 ip address 10.20.10.1 255.255.255.0
 no shutdown
exit

! --- 3. Jalur ke Switch GUEST (Fisik) ---
interface Ethernet1/1
 description JALUR-GUEST-FISIK
 ip address 10.20.50.1 255.255.255.0
 no shutdown
exit

! --- 4. Routing Default ---
ip route 0.0.0.0 0.0.0.0 192.168.10.1

! --- 5. DHCP Server ---
ip dhcp excluded-address 10.20.10.1 10.20.50.1

ip dhcp pool MHS_POOL
 network 10.20.10.0 255.255.255.0
 default-router 10.20.10.1
 dns-server 8.8.8.8
exit

ip dhcp pool GUEST_POOL
 network 10.20.50.0 255.255.255.0
 default-router 10.20.50.1
 dns-server 8.8.8.8
exit

end
write memory

# Cek Status Interface & IP Address
show ip interface brief

# Cek Routing (Jalur Internet)
show ip route

# Cek Konfigurasi Pool
show run | section dhcp

# Cek Klien yang Terhubung - Paling Penting
show ip dhcp binding

# Cek Koneksi Internet (Ping dari Router)
ping 8.8.8.8
ping 192.168.xx.1 # 10, 20, atau 40

# Cek Konfigurasi NAT (Sangat Penting)
show ip nat statistics