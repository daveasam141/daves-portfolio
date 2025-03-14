##### Enroll Client with FreeIPA
### 1. Install IPA client 
# On the client machine, install the ipa-client package.
sudo dnf install ipa-client -y
![alt text](<Screenshot 2025-03-10 at 10.03.15 PM.png>)

### 2. Configure the IPA Client:
# Run the IPA client installation and enrollment command. (client must have a FQDN as a hostname for IPA, client must also be able to resolve ipa server domain name. also make sure ldap port is opened on server )
sudo ipa-client-install --domain=example.com --server=ipa.example.com --realm=EXAMPLE.COM --mkhomedir
sudo ipa-client-install --domain=example.com --server=ipa.example.com --realm=EXAMPLE.COM --mkhomedir
![alt text](<Screenshot 2025-03-10 at 11.22.30 PM.png>)

