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

# buat rule sederhana untuk mendeteksi ping
cat > /etc/suricata/rules/test.rules <<EOF
alert icmp any any -> $HOME_NET any (msg:"[ALERT] Ada PING terdeteksi!"; sid:10001; rev:1;)
EOF

# jalankan di background
suricata -c /etc/suricata/suricata.yaml -i eth1 -D

# hentikan suricata untuk keperluan testing
service suricata stop

# cek proses suricata
ps aux | grep suricata
# tampilkan log fast.log
tail -f /var/log/suricata/fast.log




