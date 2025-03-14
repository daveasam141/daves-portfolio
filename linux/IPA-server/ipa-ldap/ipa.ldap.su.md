### Working with IPA server ldap service 
### Might need to obtain ticket from kerberos  for admin user to access IPA server
kinit admin

sudo ipactl status 
![alt text](<Screenshot 2025-03-09 at 9.59.05 PM.png>)

## Task1: Create an LDAP user
ipa user-add jdoe --first=John --last=Doe --password

# Verify user in LDAP
ldapsearch -x -LLL -D "cn=Directory Manager" -W -b "dc=havennn,dc=com" "(uid=jdoe)"
![alt text](<Screenshot 2025-03-09 at 10.12.05 PM.png>)

## Task2: Set an expiry date for User account 
ipa user-mod jdoe --setattr krbPasswordExpiration=20250401000000Z
![alt text](<Screenshot 2025-03-09 at 10.21.59 PM.png>)

## Task 3: Reset a User’s Password
ipa user-mod jdoe --password
![alt text](<Screenshot 2025-03-09 at 10.24.54 PM.png>)

## Task 4: Create a group and assign a user to a it
ipa group-add devops --desc="DevOps Team"
ipa group-add-member devops --users=jdoe
![alt text](<Screenshot 2025-03-09 at 10.31.57 PM.png>)
![alt text](<Screenshot 2025-03-09 at 10.31.26 PM.png>)
![alt text](<Screenshot 2025-03-09 at 10.34.21 PM.png>)

## Task 5: Delete a User
ipa user-del jdoe
![alt text](<Screenshot 2025-03-09 at 10.38.26 PM.png>)
# verify deletion 
ipa user-find jdoe
![alt text](<Screenshot 2025-03-09 at 10.41.00 PM.png>)


## Task 6: Allow LDAP user to ssh into server 
# log into an ldap user and create ssh keys
# Add an SSH public key for the user:
ipa user-mod Hasam --sshpubkey="$(cat /home/jdoe/.ssh/id_rsa.pub)"