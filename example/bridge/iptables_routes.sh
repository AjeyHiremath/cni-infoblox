# Run this script with sudo options, Assuming your master node is tainted.

# Default bridge name(cni0) is. If different name is preferred replace with that name. 

iptables -A FORWARD -o cni0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o cni0 -j ACCEPT
iptables -A FORWARD -i cni0 ! -o cni0 -j ACCEPT
iptables -A FORWARD -i cni0 -o cni0 -j ACCEPT

# Default interface name(eth0) is used. If your nodes have different name use that inerface name.

ip route add 10.15.20.0/24 via <master vm ip> dev eth0 # remove this line master node
ip route add 10.15.21.0/24 via <node1 vm ip> dev eth0 # remove this line in node1 node
ip route add 10.15.22.0/24 via <node2 vm ip> dev eth0 # remove this line in node2 node

mkdir -p /etc/cni/net.d

# copy respective cni network conf to /etc/cni/net.d
