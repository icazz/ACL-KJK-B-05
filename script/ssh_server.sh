#!/bin/bash

# Database
echo "nameserver 8.8.8.8" > /etc/resolv.conf

apt-get update
apt-get install openssh-server -y
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

service ssh start
passwd
# isi pass
echo "ADUH KENA HACK" > /root/flag.txt

# uji: ssh root@10.20.20.200

# classroom
apt-get install openssh-server -y
service ssh start
useradd -m -s /bin/bash mahasiswa1
passwd mahasiswa1
# mahasiswa1:qwerty

useradd -m -s /bin/bash mahasiswa2
passwd mahasiswa2
# mahasiswa2:asdfgh

# login: ssh mahasiswa@10.20.20.101
# hapus kunci lama
ssh-keygen -R 10.20.30.11

netstat -tuln | grep 22

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