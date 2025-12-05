#! /bin/bash

apt update
# tool pendukung
apt install software-properties-common curl -y
# Tambahkan repo resmi Suricata (opsional, tapi disarankan agar dapat versi terbaru)
add-apt-repository ppa:oisf/suricata-stable

# install Suricata
apt update
apt install suricata -y

# konfigurasi Suricata
cat > /etc/suricata/suricata.yaml <<EOF
%YAML 1.1
---

# BAGIAN 1: DEFINISI VARIABEL
vars:
  address-groups:
    HOME_NET: "[192.168.0.0/16, 10.0.0.0/8]"
    EXTERNAL_NET: "!$HOME_NET"

# BAGIAN 2: PENGATURAN RULES
default-rule-path: /etc/suricata/rules

rule-files:
  - test.rules

# BAGIAN 3: PENGATURAN INTERFACE (INPUT)
# Pastikan interface ini sesuai dengan arah PC Mahasiswa (eth1)
af-packet:
  - interface: eth1
    cluster-id: 99
    cluster-type: cluster_flow
    defrag: yes

# BAGIAN 4: PENGATURAN LOG (OUTPUT)
outputs:
  - fast:
      enabled: yes
      filename: fast.log
      append: yes

  - stats:
      enabled: yes
      filename: stats.log
      interval: 8

# BAGIAN 5: TWEAK KHUSUS SIMULASI
checksum-validation: no
EOF

cat > /etc/suricata/rules/test.rules <<EOF
# RULE 0: TEST KONEKSI (Ping)
# memastikan Suricata hidup dan bisa melihat paket.
alert icmp any any -> any any (msg:"[INFO] Test Ping Terdeteksi"; sid:10001; rev:1;)

# RULE 1: DETEKSI PORT SCANNING (Nmap)
# Skenario: Mahasiswa scan subnet Riset.
# Logika: Jika ada lebih dari 20 paket SYN (permintaan koneksi) dalam 10 detik.
alert tcp 10.20.10.0/24 any -> 10.20.30.0/24 any (msg:"[BAHAYA] Port Scanning (SYN Scan) dari Mahasiswa ke Riset"; flags:S; threshold: type both, track by_src, count 20, seconds 10; sid:20001; rev:1;)

# RULE 2: DETEKSI SSH BRUTE FORCE
# Skenario: Percobaan login paksa ke Server Riset (10.20.30.10).
# Logika: Jika ada 5 kali percobaan koneksi baru (SYN) ke port 22 dalam 30 detik.
alert tcp 10.20.10.0/24 any -> 10.20.30.10 22 (msg:"[KRITIS] Indikasi SSH Brute Force ke Server Riset"; flags:S; threshold: type both, track by_src, count 5, seconds 30; sid:20002; rev:1;)

# RULE 3: DETEKSI DATA EXFILTRATION (Pencurian File HTTP)
# Skenario: Server Riset mengirim data (file) ke Mahasiswa.
# Logika: Traffic dari Port 80 (Server) menuju Mahasiswa.
# 'flow:established' memastikan ini bukan sisa paket, tapi koneksi yang terjadi.
alert tcp 10.20.30.10 80 -> 10.20.10.0/24 any (msg:"[ALERT] Data Exfiltration - Transfer File HTTP dari Server Riset ke Mahasiswa"; flow:established,from_server; content:"HTTP"; sid:20003; rev:1;)
EOF

# jalankan di background
suricata -c /etc/suricata/suricata.yaml -i eth1 -D

# hentikan suricata untuk keperluan testing
service suricata stop
# matikan proses lama
killall suricata
rm /var/run/suricata.pid 2>/dev/null

# cek proses suricata
ps aux | grep suricata
# tampilkan log fast.log
tail -f /var/log/suricata/fast.log




