# cek ip di admin, akademik, dan guest
ip dhcp

# cek ip di hms dan riset
show ip

# set ip statis di node riset
ip 10.20.30.99 255.255.255.0 10.20.30.1
save
ping 10.20.30.1

# set ip statis di mhs
ip 10.20.10.99 255.255.255.0 10.20.10.1
save
ping 10.20.10.1