#!/bin/bash

# srv syslog
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update
apt-get install rsyslog -y
nano /etc/rsyslog.conf
# provides UDP syslog reception
# module(load="imudp")       <-- Hilangkan #
# input(type="imudp" port="514")  <-- Hilangkan #

service rsyslog restart

# firewall
echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt update
apt-get install rsyslog -y
nano /etc/rsyslog.conf
# Kirim semua log ke srv-syslog
# *.* @10.20.40.100:514
service rsyslog restart

# cek di srv-syslog: tail -f /var/log/syslog