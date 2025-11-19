enable
configure terminal

! ===== 1. Interface ke MikroTik (Transit) =====
interface Ethernet0/0
  ip address 192.168.10.2 255.255.255.252
  no shutdown
exit

! ===== 2. Interface ke Switch (TRUNK) =====
interface FastEthernet1/0
  description TRUNK-KE-SWITCH-MHS
  no shutdown
exit

! Sub-Interface VLAN 10 (Mahasiswa)
interface FastEthernet1/0.10
  encapsulation dot1Q 10
  ip address 10.20.10.1 255.255.255.0
exit

! Sub-Interface VLAN 50 (Guest)
interface FastEthernet1/0.50
  encapsulation dot1Q 50
  ip address 10.20.50.1 255.255.255.0
exit

! ===== 3. Default Route =====
ip route 0.0.0.0 0.0.0.0 192.168.10.1 ! Gateway ke MikroTik

! ===== 4. DHCP Server (Mhs & Guest) =====
ip dhcp excluded-address 10.20.10.1 10.20.50.1
ip dhcp pool MHS_POOL
  network 10.20.10.0 255.255.255.0
  default-router 10.20.10.1
  dns-server 8.8.8.8
ip dhcp pool GUEST_POOL
  network 10.20.50.0 255.255.255.0
  default-router 10.20.50.1
  dns-server 8.8.8.8

end
write memory