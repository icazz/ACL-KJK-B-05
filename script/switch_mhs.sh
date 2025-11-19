configure terminal
! Port ke R2 HARUS TRUNK
interface eth0
  switchport mode trunk
exit
! Port Mhs
interface eth1
  switchport access vlan 10
  switchport mode access
exit
! Port Guest
interface eth2
  switchport access vlan 50
  switchport mode access
exit
end