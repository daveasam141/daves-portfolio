#### Setting up a DnS Server on RHEL 9 (Internal and forwarding)

## 1. Install Bind 
sudo dnf update -y
sudo dnf install -y bind bind-utils


# Make sure to have port 53 open on server 
sudo firewall-cmd --list-ports
sudo firewall-cmd --list-services 
sudo firwall-cmd --zone=public --list-all

## 2. Configure bind 
sudo vi /etc/named.conf ###bind's main config file 
# Modify Allow queries from your network (replace 192.168.1.0/24 with your subnet):
allow-query { localhost; 192.168.1.0/24; };
# Define the forward and internal zones for your domain:
options {
    listen-on port 53 { 127.0.0.1; 192.168.1.10; };  # Replace with your server's IP
    directory "/var/named";
    allow-query { localhost; 192.168.1.0/24; };  # Allow internal network queries
    forwarders { 8.8.8.8; 8.8.4.4; };  # Global forwarders
};

# Internal Zone Configuration
zone "internal.example.com" IN {
    type master;
    file "/var/named/internal.example.com.db";
    allow-update { none; };
};

# Forward Zone Configuration
zone "example.com" IN {
    type forward;
    forwarders { 8.8.8.8; 8.8.4.4; };
};

## Check for errors
sudo named-checkconf

# Create internal zone file
sudo vi /var/named/internal.example.com.db

# Add the following DNS records (Make sure to change ips)
$TTL 86400
@   IN  SOA  ns1.internal.2waveyyyy.com. root.internal.2waveyyyy.com. (
        2024030501 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400      ; Minimum TTL
)

@   IN  NS   ns1.internal.2waveyyyy.com.

ns1  IN  A    192.168.1.10

host1  IN  A   192.168.1.20
host2  IN  A   192.168.1.30
host3  IN  A   192.168.1.40

$
## Set correct permission for the user
sudo chown named:named /var/named/internal.example.com.db
sudo chmod 640 /var/named/internal.example.com.db
## Check for errors
sudo named-checkconf
sudo named-checkzone internal.2waveyyyy.com /var/named/internal.2waveyyyy.com.zone


### 3. Restart and enable bind (named service )
sudo systemctl restart named 
sudo systemctl enable named 
sudo systemctl status named 
## Tests DNS server (replace ip with dns server ip)
dig @192.168.1.10 internal.2waveyyyy.com

### 4. Make the bind dns server your default dns server (persistent)
sudo nmcli con mod "your-network-connection-name" ipv4.dns "192.168.1.10"
sudo nmcli con up "your-network-connection-name"
## Test dns server again using dig and ping 
dig internal.2waveyyyy.com
ping internal.2waveyyyy.com






