# Linux 

### Cloud Platforms 

1. AWS 
2. Azure 
3. Google Cloud  
4. Hcloud (Hetzner)

### On-Premises Infrastructure
1. VMware 

# Project 1

###########################################################################################
#                                                                                         #
#  Module 1                                                                               #
#  Creation & connection to Linux servers across AWS, Azure, Hcloud, and VMware.          #     
#                                                                                         #
###########################################################################################

### Case Study #1
On the console, manually create a Linux instance:

1. Create an EC2 instance in AWS (Amazon).
2. Create an instance (VM) in Hcloud (Hetzner).

### Case Study #2
On the CLI, manually create a Linux instance:

1. Create an EC2 instance in AWS (Amazon).
2. Create an instance (VM) in Hcloud (Hetzner).
3. Create an instance (VM) in AWS (Azure).

### Case Study #3
On the CLI, manually create a Linux instance:

1. Create an EC2 instance in AWS (Amazon).
2. Create an instance (VM) in Hcloud (Hetzner).
3. Create an instance (VM) in AWS (Azure).

### Case Study #4
On the console, manually create a Linux instance:

1. Create an instance (VM) in VMware.

###########################################################################################
#                                                                                         #
#  Module 2                                                                               #
#  Learning Linux, LVM, Ports, SSH, SCP, Webserver, bash, mkdir, vim, yum, apt, cd, cat.  #     
#                                                                                         #
###########################################################################################

Assignment: Create a simple portfolio webpage and ensure that the webpage is functional.
Due date: 

### Task #1
1.⁠ ⁠Create a Linux Virtual machine  in Hetzner using Ubuntu or CentOS and name it Firstname-vm1
2.⁠ ⁠Create and attach a 5 GB volume and name it Firstname-1
3.⁠ ⁠Create a firewall that only allows ports 22, 80, 8080, and 443. Assign a unique name called Firstname-1
4.⁠ ⁠Ensure root user can log in via SSH with both key and password.
5.⁠ ⁠Ensure linux packages are up-to-date by using yum or apt-get to update the system. 

### Task #2
Create a web server using any template from the "devops-engineers-portfolio" repository.

1.⁠ ⁠Clone the course repository git@github.com:devops-engineering-training-org/devops-engineers-portfolio.git to your local machine.
2.⁠ ⁠Find and copy the webpage directory from the "devops-engineers-portfolio" repository remotely to your instance using the IP address and user credentials.
3.⁠ ⁠Install Apache (httpd) to serve as your web  for hosting your portfolio web page.
4.⁠ ⁠Test your website using the IP address of your VM or instance.

### Task #3
1.⁠ ⁠Create a backup copy of webpage directory on your Linux server 
2. Change directory to /var/www/html/
3. Now edit index.html file and change Kamal to your first name and restart the httpd service. (Note that you will be using vi or vim to edit Linux file) example   vi index.html. Work with your team lead If you have any issue. 
4.⁠ ⁠Test your website using the IP address of your instance. 
5.⁠ ⁠Submit your assignment by taking screenshots of your webpage and submitting them in your group with your name written next to each screenshot.

### Task #4 
1. Create a directory in your instance as /opt/scripts.
2. Create a file under the directory called long-running-memory-proc.sh.
3. Grant execute permissions to allow you to execute the script.
4. Run the script and take a screenshot, then submit it to your team lead or instructor.

### What You'll Learn 
The purpose of assignment #1 is to ensure that we are familiar with navigating the file system using basic Linux commands such as: 

``ssh, cd, ls, ll, pwd, cp, scp, git, vi, regex, and absolute path.``

File - Regular file 
Directory - Folder / sub-

### Syntax
Copy file within the same system / copy file locally 
cp <source> <target>

ex.
cp file_name /home/swilliams 

Copy file remotely or from one server to the server 
### Syntax
scp <source> <username@ip_address>
scp -r /data1 <username@ip_address>

### Take home from this assignment:

1. Learn how to install Linux server
2. Learn how to login into Linux server
3. Learn to use basic Linux command to interract/navigate with the Operating system 
4. Learn how to transfer file from local system to remote server 
5. Learn how to install basic web server in Linux 

Additionally, installing and configuring a simple website in Linux using ``yum`` and ``httpd``, and managing Linux services with ``systemctl`` for starting, stopping, and checking status. It also requires understanding the use cases of Linux.

In your notes, you should add annotations that explain how you used each of the mentioned commands.

