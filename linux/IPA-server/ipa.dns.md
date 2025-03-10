### Setting up IPA server with DNS

# 1. Set Hostname and update system 
hostnamectl set-hostname ipa.example.com
echo "192.168.1.100 ipa.example.com ipa" >> /etc/hosts
sudo dnf update -y
![alt text](<Screenshot 2025-03-08 at 3.57.39 PM.png>)
![alt text](<Screenshot 2025-03-08 at 3.53.44 PM.png>)


# 2. Configure FreeIPA with DNS
# Run the FreeIPA installation Wizard 
sudo ipa-server-install --setup-dns
# Install FreeIPA Server DNS 
sudo dnf install freeipa-server freeipa-server-dns -y
![alt text](<Screenshot 2025-03-09 at 6.52.11 PM.png>)
![alt text](<Screenshot 2025-03-09 at 6.55.23 PM.png>)

# Open necessary Ports for IPA sever services
![alt text](<Screenshot 2025-03-09 at 7.09.55 PM.png>)

# Obtain Kerberos ticket to allow use of IPA tools
kinit admin

# Test DNS server by getting zones and testing DNS resolution
ipa dnszone-find
![alt text](<Screenshot 2025-03-09 at 7.33.16 PM.png>)
dig @<dns_server_ip> <domain_name>
![alt text](<Screenshot 2025-03-09 at 7.35.15 PM.png>)
# For reverse resolution
dig -x <ip_to_resolve> @<dns_server_to_query>\
![alt text](<Screenshot 2025-03-09 at 7.41.38 PM.png>)


# 3.  Add DNS Records in FreeIPA
# Add an A record and test resolution
ipa dnsrecord-add havennn.com test  --a-rec <ip>
![alt text](<Screenshot 2025-03-09 at 9.31.26 PM.png>)


