# Penyerang: PC_Mhs (VLAN 10 - 10.20.10.x)
# Target: PC_Admin (VLAN 40 - 10.20.40.x)
# Penjaga (Firewall): MikroTikCHR-1

# pc admin
ip dhcd

# pc mhs
ping 10.20.40.x # ip admin, harusanya berhasil (belum di setting blokir)

# firewall
/ip firewall filter add chain=forward src-address=10.20.10.0/24 dst-address=10.20.40.0/24 action=drop log=yes log-prefix="[BLOKIR] " place-before=0

# aktif dan nonaktif
/ip firewall filter print

/ip firewall filter disable 0 # nonaktifkan rule blokir
/ip firewall filter enable 0 # aktifkan rule blokir
# simulasi serangan

# pc mhs 
ping 10.20.40.x # ip admin, harusanya gagal (di blokir)
# Request timed out atau Destination host unreachable