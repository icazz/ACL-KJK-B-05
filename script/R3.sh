enable
configure terminal

! ===== 1. Interface ke MikroTik (Transit) =====
interface Ethernet0/0
  ip address 192.168.20.2 255.255.255.252
  no shutdown
exit

! Interface ke Switch (TRUNK) - Gunakan F1/0
interface FastEthernet1/0
  description TRUNK-KE-SWITCH-AKD
  no shutdown
exit

! Sub-Interface VLAN 20 (Akademik)
interface FastEthernet1/0.20
  encapsulation dot1Q 20
  ip address 10.20.20.1 255.255.255.0
exit

! Sub-Interface VLAN 30 (Riset)
interface FastEthernet1/0.30
  encapsulation dot1Q 30
  ip address 10.20.30.1 255.255.255.0
exit

! ===== 2. Default Route =====
ip route 0.0.0.0 0.0.0.0 192.168.20.1 ! Gateway ke MikroTik

! ===== 3. DHCP Server (Akademik & Riset) =====
ip dhcp excluded-address 10.20.20.1 10.20.30.1
ip dhcp pool AKD_POOL
  network 10.20.20.0 255.255.255.0
  default-router 10.20.20.1
  dns-server 8.8.8.8
ip dhcp pool RISET_POOL
  network 10.20.30.0 255.255.255.0
  default-router 10.20.30.1
  dns-server 8.8.8.8

end
write memory