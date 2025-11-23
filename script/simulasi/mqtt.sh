apt-get update
apt-get install mosquitto -y

service mosquitto start
netstat -tuln | grep 1883
# Harus muncul: tcp    0   0 0.0.0.0:1883   0.0.0.0:* LISTEN

# penyerang 
apt-get update
apt-get install mosquitto-clients -y
# Perintah ini mencoba terhubung ke server database di port 1883
mosquitto_pub -h 10.20.20.200 -t test/topic -m "p serang"