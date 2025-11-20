# Membuktikan aturan ALLOW Mahasiswa ke Akademik (HTTP) bekerja, tapi hanya HTTP.

# firewall
# 1. Aturan IZINKAN HTTP (TCP port 80)
# Ini memastikan kalau ada trafik web, dia DIBOLEHKAN lewat.
/ip firewall filter add \
chain=forward \
protocol=tcp \
dst-port=80 \
src-address=10.20.10.0/24 \
dst-address=10.20.20.0/24 \
action=accept \
comment="SKENARIO-2: Allow HTTP Mhs ke Akd" \
place-before=0

# 2. Aturan BLOKIR PING (ICMP)
# Ini memastikan kalau mahasiswa iseng nge-ping, dia DITOLAK.
/ip firewall filter add \
chain=forward \
protocol=icmp \
src-address=10.20.10.0/24 \
dst-address=10.20.20.0/24 \
action=drop \
log=yes \
log-prefix="[BLOKIR-PING] " \
comment="SKENARIO-2: Block Ping Mhs ke Akd" \
place-before=1

# Cek nomor aturan
/ip firewall filter print

# Matikan aturan Block Ping (Misal nomor 1)
/ip firewall filter disable 1

# skenario testing
# pc mhs
ping 10.20.20.2 -t

# harusnya bisa, lalu pasang firewallnya
# firewall
/ip firewall filter enable 1

# pc mhs
ping 10.20.20.2 -t

# harusnya tidak bisa (Request timed out atau Destination host unreachable)