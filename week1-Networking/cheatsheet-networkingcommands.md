Here’s a **cheat sheet** for essential **networking commands** in Linux. These commands will help you manage and troubleshoot your network connections, configure interfaces, and perform network diagnostics.

---

### **1. Checking Network Interfaces**
- **List network interfaces**:
  ```bash
  ip a
  ```
  or
  ```bash
  ifconfig
  ```

- **Show interface details** (e.g., IP addresses, MAC address):
  ```bash
  ip addr show
  ```
  or
  ```bash
  ifconfig <interface-name>
  ```

- **Display active network interfaces**:
  ```bash
  ip link show
  ```

---

### **2. Managing Network Interfaces**
- **Bring an interface up**:
  ```bash
  sudo ip link set <interface-name> up
  ```
  or
  ```bash
  sudo ifconfig <interface-name> up
  ```

- **Bring an interface down**:
  ```bash
  sudo ip link set <interface-name> down
  ```
  or
  ```bash
  sudo ifconfig <interface-name> down
  ```

- **Assign a static IP address**:
  ```bash
  sudo ip addr add <IP-address>/<netmask> dev <interface-name>
  ```

- **Remove an IP address from an interface**:
  ```bash
  sudo ip addr del <IP-address>/<netmask> dev <interface-name>
  ```

- **Change the MAC address**:
  ```bash
  sudo ifconfig <interface-name> hw ether <new-mac-address>
  ```

---

### **3. Viewing Routing Table**
- **Display the routing table**:
  ```bash
  ip route show
  ```
  or
  ```bash
  route -n
  ```

- **Add a static route**:
  ```bash
  sudo ip route add <destination-network>/<netmask> via <gateway-ip>
  ```

- **Delete a route**:
  ```bash
  sudo ip route del <destination-network>/<netmask> via <gateway-ip>
  ```

---

### **4. DNS Configuration**
- **Show DNS configuration**:
  ```bash
  cat /etc/resolv.conf
  ```

- **Test DNS resolution**:
  ```bash
  nslookup <domain-name>
  ```
  or
  ```bash
  dig <domain-name>
  ```

---

### **5. Checking Network Status**
- **Show current network connections**:
  ```bash
  netstat -tuln
  ```

- **Show listening ports**:
  ```bash
  sudo netstat -tuln
  ```

- **Show detailed information about active connections**:
  ```bash
  sudo ss -tuln
  ```

- **Check your external IP address**:
  ```bash
  curl ifconfig.me
  ```
  or
  ```bash
  wget -qO- ifconfig.me
  ```

---

### **6. Testing Network Connectivity**
- **Ping an IP address or hostname**:
  ```bash
  ping <ip-address-or-hostname>
  ```

- **Ping a specific number of times**:
  ```bash
  ping -c <count> <hostname>
  ```

- **Traceroute to a destination** (traces the path packets take to reach a host):
  ```bash
  traceroute <hostname-or-ip>
  ```
The command in Windows to trace the route is tracert.
Basic Syntax:
```bash
tracert <hostname or IP address>
 ```
For example, to trace the route to Google:
```bash
tracert www.google.com
```
tracert (Windows) or traceroute (Linux/MacOS) are useful tools for diagnosing network routes.
They show each router or hop between your computer and the destination and measure the round-trip time.

- **Test connectivity to a specific port**:
  ```bash
  nc -zv <hostname-or-ip> <port-number>
  ```

- **Test DNS resolution**:
  ```bash
  nslookup <hostname>
  ```

---

### **7. Network Interface Diagnostics**
- **Check network interface statistics**:
  ```bash
  netstat -i
  ```

- **Display network interface statistics** (e.g., packets sent/received):
  ```bash
  ifstat
  ```

- **Monitor network interfaces in real-time**:
  ```bash
  sudo iftop
  ```

---

### **8. Network Traffic Control**
- **Limit bandwidth on an interface** (e.g., limit download speed to 1Mbit):
  ```bash
  sudo tc qdisc add dev <interface-name> root tbf rate 1mbit burst 32kbit latency 400ms
  ```

- **Show the current bandwidth usage**:
  ```bash
  sudo iftop
  ```

---

### **9. Firewall Configuration (using `iptables`)**
- **View current firewall rules**:
  ```bash
  sudo iptables -L
  ```

- **Allow incoming traffic on a specific port**:
  ```bash
  sudo iptables -A INPUT -p tcp --dport <port-number> -j ACCEPT
  ```

- **Block incoming traffic on a specific port**:
  ```bash
  sudo iptables -A INPUT -p tcp --dport <port-number> -j REJECT
  ```

- **Save firewall rules**:
  ```bash
  sudo service iptables save
  ```

---

### **10. Network Utilities**
- **Check available network interfaces and their status**:
  ```bash
  nmcli device status
  ```

- **Check current network bandwidth usage**:
  ```bash
  sudo nload
  ```

- **Network packet capture** (requires `tcpdump`):
  ```bash
  sudo tcpdump -i <interface-name>
  ```

- **Display ARP table**:
  ```bash
  arp -n
  ```

- **Show IP address of the machine (shortcut)**:
  ```bash
  hostname -I
  ```

---

### **11. Advanced Networking**
- **View active network connections**:
  ```bash
  lsof -i
  ```

- **Show current network connections and associated processes**:
  ```bash
  sudo netstat -tulpn
  ```

- **Display TCP/UDP connections**:
  ```bash
  ss -t -a
  ```

- **Resolve a domain to an IP address**:
  ```bash
  host <domain-name>
  ```

---

### **12. DHCP (Dynamic Host Configuration Protocol)**
- **Request a new IP address via DHCP**:
  ```bash
  sudo dhclient
  ```

- **Release the current DHCP lease**:
  ```bash
  sudo dhclient -r
  ```

---

### **13. System Networking Information**
- **Show system’s network statistics**:
  ```bash
  sudo sar -n DEV 1 3
  ```

- **Display detailed system network information**:
  ```bash
  sudo lshw -class network
  ```

---

### **14. Network File Systems (NFS & SMB)**
- **Mount an NFS share**:
  ```bash
  sudo mount -t nfs <nfs-server-ip>:/path/to/share /mnt
  ```

- **Unmount an NFS share**:
  ```bash
  sudo umount /mnt
  ```

- **Mount a SMB share**:
  ```bash
  sudo mount -t cifs //server-ip/share /mnt -o username=<username>,password=<password>
  ```

---

### **15. Network Time Protocol (NTP)**
- **Synchronize system time with NTP**:
  ```bash
  sudo ntpdate pool.ntp.org
  ```

- **Start the NTP service**:
  ```bash
  sudo systemctl start ntp
  ```

---

This **networking essentials cheat sheet** will help you with common network commands and configurations in Linux. Whether you're configuring network interfaces, troubleshooting connectivity issues, or monitoring traffic, these commands cover most of the tasks you'll need.
