enable
configure terminal

! Ke MikroTik
interface Ethernet0/0
  ip address 192.168.40.2 255.255.255.252
  no shutdown
exit

! Ke Switch Admin (Langsung Fisik, Tanpa VLAN Tagging)
interface FastEthernet1/0
  ip address 10.20.40.1 255.255.255.0
  no shutdown
exit

! Routing & DHCP
ip route 0.0.0.0 0.0.0.0 192.168.40.1
ip dhcp excluded-address 10.20.40.1

ip dhcp pool ADM_POOL
  network 10.20.40.0 255.255.255.0
  default-router 10.20.40.1
  dns-server 8.8.8.8
exit

end
write memory