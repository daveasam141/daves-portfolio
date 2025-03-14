#### Setting uo NFS Server on IPA 
## 1. Download NFS packages and enable nfs service 
sudo dnf install nfs-utils -y
sudo systemctl enable --now nfs-server rpcbind nfs-idmapd
![alt text](<Screenshot 2025-03-10 at 7.58.05 PM.png>)

## 2. Configure the NFS Export Directory
sudo mkdir -p /export/home
sudo chmod 755 /export/home
![alt text](<Screenshot 2025-03-10 at 8.01.02 PM.png>)

# Set ownership to root or an appropriate user:
chown root:root /export/home
![alt text](<Screenshot 2025-03-10 at 8.36.45 PM.png>)

## 3. Configure Exports for NFSv4 with Kerberos

# Edit the exports file to define what will be shared. 
sudo vi /etc/exports

# Add the following line to export /export/home to your FreeIPA domain clients securely:
/export/home  *(rw,sync,root_squash,sec=krb5p)
![alt text](<Screenshot 2025-03-10 at 8.40.26 PM-1.png>)

# Apply the changes:
exportfs -arv
![alt text](<Screenshot 2025-03-10 at 8.41.50 PM.png>)

## 4. Configure NFS to Use FreeIPA for Identity Mapping. 
# Ensure the ID mapping service is enabled:
echo "NFS4_DOMAIN=havennn.com" >> /etc/idmapd.conf   *might need to log in as root for this if sudo is causing issues ***Replace freeipa.local with your actual FreeIPA domain.
![alt text](<Screenshot 2025-03-10 at 8.44.25 PM.png>)

sudo systemctl restart nfs-idmapd
![alt text](<Screenshot 2025-03-10 at 8.46.10 PM.png>)

## 5. Configure Kerberos for NFS (Secure Mounting)

#  Create NFS Kerberos Principal in FreeIPA
*** if running the nfs server on the same machine as the ipa server do the following first: 
# create a dns record on the ipa server dns
ipa dnsrecord-add havennn.com nfsserver  --a-rec <ip_of_nfs_server>
# add the nfs server as a host in IPA
ipa host-add <hostname_of_nfsserver>
![alt text](<Screenshot 2025-03-10 at 9.18.37 PM.png>)

# Run the following command to create a Kerberos principal for the NFS server(This registers your nfs server with FreeIPA  and allows clients to securely authenticate with the NFS Server):
ipa service-add nfs/your-server.example.com
ipa service-add nfs/nfsserver.havennn.com
![alt text](<Screenshot 2025-03-10 at 9.23.44 PM.png>)


## 6. Configure SELinux and Firewall
sudo semanage fcontext -a -t nfs_t '/your/shared/directory(/.*)?'
sudo restorecon -Rv /your/shared/directory
![alt text](<Screenshot 2025-03-10 at 9.37.09 PM.png>)

# Allow NFS through the firewall
sudo firewall-cmd --permanent --add-service=nfs
sudo firewall-cmd --permanent --add-service=rpc-bind
sudo firewall-cmd --permanent --add-service=mountd
sudo firewall-cmd --reload
![alt text](<Screenshot 2025-03-10 at 9.39.24 PM.png>)

### 7. Test NTP server 
# You can try mounting the NFS share on a client:
sudo mount -t nfs4 nfsserver.havennn.com:/your/shared/directory /mnt
# If you’re using Kerberos, make sure the client has a valid Kerberos ticket:
kinit user@HAVENNN.COM