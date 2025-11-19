configure terminal
! Port ke R3 HARUS TRUNK
interface eth0
  switchport mode trunk
exit
! Port Akademik
interface eth1
  switchport access vlan 20
  switchport mode access
exit
! Port Riset
interface eth2
  switchport access vlan 30
  switchport mode access
exit
end