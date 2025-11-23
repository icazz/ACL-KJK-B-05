#!/bin/bash

# Web Akademik
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get install apache2 -y
service apache2 start
echo "<h1>INFO DAFTAR ITS KAK | KJK SERUU ABIIEZZ</h1>" > /var/www/html/index.html
netstat -tuln | grep 80

# cek web-akademik: curl 10.20.20.100

