WAN_IF=wlo1                 # interface du PC vers le smartphone
LAN_IF=vboxnet0        # interface du PC vers le LAN (serveur)
PC_IP=192.168.56.1
SRV_IP=192.168.1.70
EXT_PORT=2300               # port exposé sur Internet
SRV_PORT=22                 # port SSH du serveur


# IPv4
for tbl in filter nat mangle raw security; do
  sudo iptables -t $tbl -F  || true   # flush rules
  sudo iptables -t $tbl -X  || true   # delete user chains
  sudo iptables -t $tbl -Z  || true   # zero counters
done

# IPv6
for tbl in filter nat mangle raw security; do
  sudo ip6tables -t $tbl -F || true
  sudo ip6tables -t $tbl -X || true
  sudo ip6tables -t $tbl -Z || true
done


sudo sh -c 'iptables-save  > /etc/iptables/rules.v4'
sudo sh -c 'ip6tables-save > /etc/iptables/rules.v6'
# DNAT : WAN:2300 -> SRV_IP:22
sudo iptables -t nat -A PREROUTING  -i wlo1 -p tcp --dport 2300 \
  -j DNAT --to-destination 192.168.100.20:22

# Autoriser le passage (FORWARD) dans les deux sens pour ce flux
sudo iptables -A FORWARD -i wlo1 -o enp0s20f0u3u2 -p tcp -d 192.168.100.20 --dport 22 \
  -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i enp0s20f0u3u2 -o wlo1 -p tcp -s 192.168.100.20 --sport 22 \
  -m state --state ESTABLISHED,RELATED -j ACCEPT

# NAT de sortie vers le Wi-Fi (utile de toute façon)
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE

# (Conseillé) SNAT vers l'IP LAN du PC pour garantir le retour,
# même si la gateway du serveur n’est pas le PC :
sudo iptables -t nat -A POSTROUTING -o enp0s20f0u3u2 -d 192.168.100.20 -p tcp --dport 22 \
  -j SNAT --to-source 192.168.100.10

