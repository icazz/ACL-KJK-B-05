enable
configure terminal

! ===== 1. Interface ke Internet (NAT) =====
interface Ethernet0/0
  ip address dhcp           ! Ambil IP dari NAT1
  ip nat outside
  no shutdown
exit

! ===== 2. Interface ke MikroTik (WAN) =====
interface FastEthernet1/0
  ip address 192.168.1.1 255.255.255.0
  ip nat inside
  no shutdown
exit

! ===== 3. Aturan NAT =====
access-list 1 permit 192.168.1.0 0.0.0.255
ip nat inside source list 1 interface Ethernet0/0 overload

end
write memory

# Cek Status Interface & IP Address
show ip interface brief

# Cek Routing (Jalur Internet)
show ip route

# Cek Koneksi Internet (Ping dari Router)
ping 8.8.8.8

# Cek Konfigurasi NAT (Sangat Penting)
show ip nat statistics