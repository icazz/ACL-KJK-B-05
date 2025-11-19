flow config
1. R1 dulu
2. firewall/mikrotik
3. R2 + switch mhs
4. R3 + switch akademik
5. R4 + switch admin
6. Karena MikroTik tidak tahu subnet 10.20.x.x yang ada di belakang R2, R3, dan R4, Anda harus menambahkan static route di MikroTikCHR-1. [balik ke mikrotik, lalu routing lagi]
7. vpcs/client: ip dhcp, dapatkan ip yang benar

8. tes sesuai soal [script on progress]