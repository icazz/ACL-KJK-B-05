apt-get update
apt-get install netcat-traditional -y

# nyalakan listener 
nc -l -p 3306 &

# tes koneksi: pc riset
telnet 10.20.30.11 22 # port ssh harus bisa diakses mahasiswa dan tidak bisa diakses guest
telnet 10.20.30.11 3306 # port mysql tidak bisa diakses mahasiswa dan guest

# database: telnet 10.20.20.200 3306