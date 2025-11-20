enable
configure terminal
hostname R3

! --- 1. Jalur ke MikroTik ---
interface Ethernet0/0
 description KE-MIKROTIK
 ip address 192.168.20.2 255.255.255.252
 no shutdown
exit

! --- 2. Jalur ke Switch AKADEMIK (Fisik) ---
interface Ethernet1/0
 description JALUR-AKADEMIK-FISIK
 ip address 10.20.20.1 255.255.255.0
 no shutdown
exit

! --- 3. Jalur ke Switch RISET (Fisik) ---
interface Ethernet1/1
 description JALUR-RISET-FISIK
 ip address 10.20.30.1 255.255.255.0
 no shutdown
exit

! --- 4. Routing Default ---
ip route 0.0.0.0 0.0.0.0 192.168.20.1

! --- 5. DHCP Server ---
ip dhcp excluded-address 10.20.20.1 10.20.30.1

ip dhcp pool AKD_POOL
 network 10.20.20.0 255.255.255.0
 default-router 10.20.20.1
 dns-server 8.8.8.8
exit

ip dhcp pool RISET_POOL
 network 10.20.30.0 255.255.255.0
 default-router 10.20.30.1
 dns-server 8.8.8.8
exit

end
write memory