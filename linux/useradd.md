### Create a user 'john_doe' with a home directory in '/opt/users/' and a shell of '/bin/bash'
useradd john_doe -d /opt/users -s /bin/bash 

### Set a password that expires every 30 days and locks after 3 failed attempts.
passwd 
sudo chage -M 30 john_doe
sudo chage -l john_doe (username)

### Add 'john_doe' to a group called 'developers' and give them sudo access to '/usr/bin/systemctl'.
sudo groupadd developers 
sudo usermod -aG developers john_doe 
cat /etc/group ### verify that the developers group has been created
%developers ALL=(ALL) NOPASSWD: /usr/bin/systemctl ### adding the developer group to the sudoers file to run all commands with no password for the /usr/bin/systemctl directory. 
sudo -l -U john_doe ### verify that the user has the right privileges 

### Create a shared directory '/opt/shared' and allow only the 'developers' group to read and write files inside it. Ensure new files in '/opt/shared' inherit the group ownership automatically.
sudo mkdir /opt/users
sudo chown :developers /opt/shared ### change group ownership for /opt/shared to the developers group
sudo chmod 2070 /opt/shared ### Grant group permission with SETGID allowing new files in the shared directory to inherit group ownership automatically.

### Set up SSH key authentication for a user and disable password login.Restrict SSH access to only users in the 'sysadmins' group. Change the default SSH port from '22' to '2222'.
sudo useradd lanche_vincent -m -s bin/bash ### create a new user with a home directory with the bash shell as the deafault shell
sudo passwd lanche_vincent ### Create password for the new user 
sudo groupadd sysadmins ### create a sysadmin group
usermod -aG sysadmins lanche_vincent ### add the new user to the new group  
sudo su - lanche_vincent
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" ### Generate ssh key for the user
chmod 700 ~/.ssh ### set the right permissions for ssh
chmod 600 ~/.ssh/id_rsa ### set the right permissions for ssh
chmod 644 ~/.ssh/id_rsa.pub ### set the right permissions for ssh
ssh-copy-id username@server_ip ### To copy to a remote server 
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys ### save the key in the authorized keys file 
chmod 600 ~/.ssh/authorized_keys ### set the right permissions for the autthorized keys file 




