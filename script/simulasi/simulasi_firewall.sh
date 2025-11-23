#!/bin/bash

NET_MHS="10.20.10.0/24"
NET_AKAD="10.20.20.0/24"
NET_RISET="10.20.30.0/24"
NET_ADMIN="10.20.40.0/24"
NET_GUEST="10.20.50.0/24"

# Server & Port Penting
IP_DB="10.20.20.200"
IP_WEB_AKAD="10.20.20.100"
IP_CLASSROOM="10.20.20.101"
PORT_WEB="80"
PORT_SSH="22"

# 2. MEMBERSIHKAN RULE LAMA (FLUSH)
# --------------------------------------------------------
iptables -F
iptables -t nat -F
iptables -X

# Blokir semuanya kecuali yang kita izinkan secara eksplisit.
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Izinkan akses loopback (localhost)
iptables -A INPUT -i lo -j ACCEPT

# 4. FITUR STATEFUL FIREWALL (Koneksi Balik)
# --------------------------------------------------------
# Izinkan paket yang merupakan bagian dari koneksi yang sudah sah/terjalin.
# Contoh: Jika Mhs request ke Google, balasan Google diizinkan masuk.
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# ========================================================
# 5. ACCESS CONTROL LISTS (ACL) - RULE PER DIVISI
# ========================================================

# --- A. ACL ADMIN (SUPERUSER) ---
# Admin boleh mengakses SEMUA jaringan lain
iptables -A FORWARD -s $NET_ADMIN -j ACCEPT

# ### TAMBAHAN PENTING ###
# Admin juga boleh mengakses Firewall itu sendiri (untuk maintenance via SSH)
iptables -A INPUT -s $NET_ADMIN -j ACCEPT

# --- B. ACL MAHASISWA ---
# 1. Izinkan akses ke Web Akademik (HTTP)
iptables -A FORWARD -s $NET_MHS -d $IP_WEB_AKAD -p tcp --dport $PORT_WEB -j ACCEPT

# 2. Izinkan akses ke Classroom (Web & SSH)
iptables -A FORWARD -s $NET_MHS -d $IP_CLASSROOM -p tcp --dport $PORT_WEB -j ACCEPT
# ### TAMBAHAN: Agar Mhs bisa Login SSH ke Classroom ###
iptables -A FORWARD -s $NET_MHS -d $IP_CLASSROOM -p tcp --dport $PORT_SSH -j ACCEPT

# 3. Izinkan akses ke PC Riset/IoT HANYA port SSH
iptables -A FORWARD -s $NET_MHS -d $NET_RISET -p tcp --dport $PORT_SSH -j ACCEPT

# 4. Izinkan akses ke Internet (eth0)
iptables -A FORWARD -s $NET_MHS -o eth0 -j ACCEPT

# --- C. ACL GUEST ---
# 1. Izinkan akses ke Web Akademik saja
iptables -A FORWARD -s $NET_GUEST -d $IP_WEB_AKAD -p tcp --dport $PORT_WEB -j ACCEPT

# 2. Izinkan akses ke Internet
iptables -A FORWARD -s $NET_GUEST -o eth0 -j ACCEPT

# --- D. ACL RISET ---
# 1. Izinkan akses ke Internet
iptables -A FORWARD -s $NET_RISET -o eth0 -j ACCEPT

# Log akses menuju Subnet ADMIN
iptables -A FORWARD -d $NET_ADMIN -j LOG --log-prefix "[ALERT-ADMIN-ACCESS]: " --log-level 6

# Log akses menuju Subnet AKADEMIK
iptables -A FORWARD -d $NET_AKAD -j LOG --log-prefix "[INFO-AKADEMIK]: " --log-level 6


# daftar ip
Internet: 8.8.8.8

Web Akademik: 10.20.20.100

Classroom: 10.20.20.101

Database: 10.20.20.200

PC Riset: 10.20.30.11

PC Admin: 10.20.40.11

PC Mahasiswa1: 10.20.10.11
PC Mahasiswa2: 10.20.10.12

PC Guest1: 10.20.50.11
PC Guest2: 10.20.50.12

#!/bin/bash

SUBNET_ADMIN="10.20.40.0/24"

iptables -F
iptables -X

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -s $SUBNET_ADMIN -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -j DROP