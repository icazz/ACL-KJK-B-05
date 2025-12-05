#! /bin/bash

# RECONNAISSANCE (Port Scanning)
# Node Attacker: PC Mahasiswa
# Node Target: Server Riset (10.20.30.10)

# di pc mahasiswa
nmap -sS -p 1-100 10.20.30.10

# Hasil yang Diharapkan (Di Log Firewall):
[**] [1:20001:1] [BAHAYA] Port Scanning (SYN Scan) dari Mahasiswa ke Riset [**] ...