### Setting up rancher vm using esxi 

### Create a virtaul machine on esxi and attach iso(Redhat in this case)
1.	Log in to ESXi
Open a web browser and go to https://<ESXi-IP>/ui/.
Log in with your credentials.
2. Upload the ISO to the ESXi Datastore
Navigate to Storage > Select the datastore.
Click Datastore browser > Upload.
Select your ISO file and upload it.
Attach the ISO to the VM
3. Go to Virtual Machines and select the target VM.
Click Edit Settings.
Under CD/DVD Drive, choose Datastore ISO file.
Browse and select the uploaded ISO file.
Ensure Connect at Power On is checked.
Click Save.
4. Boot from the ISO
Power on or restart the VM.
Press Esc during boot to access the boot menu.
Select CD-ROM Drive to boot from the ISO.

### Install DOcker oon Rancher server 
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

### Run Rancher in a container
sudo docker run -d --name=rancher-server --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  --privileged \
  rancher/rancher:latest