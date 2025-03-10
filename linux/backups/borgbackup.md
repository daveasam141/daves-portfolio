# Project: Enterprise Linux Backup & Restore Using BorgBackup & AWS S3

## Objective:
Set up a robust backup and restore solution for Linux systems in an enterprise-like environment using BorgBackup (efficient deduplicating backup tool) and store the backups in AWS S3 via Borg's S3-compatible storage feature. You'll also implement backup automation, monitoring, and disaster recovery testing.

---

## 1. Environment Setup
You'll need:
- A **primary Linux server** (e.g., RHEL, CentOS, or Ubuntu) to be backed up. (Using RHEL in this instance)
- A **backup server** (can be another Linux VM or AWS S3 as a storage target).
- AWS CLI configured for S3 storage.


## 2. Install & Configure BorgBackup
On the primary Linux server:
sudo yum install epel-release -y  # For RHEL-based distros

## 3. Initialize the Backup Repository
If storing backups on a secondary Linux server, set up SSH-based Borg repo:

```bash
borg init --encryption=repokey borg@backup-server:/backups/myserver
```

If using **AWS S3** (via MinIO gateway for S3 compatibility):

```bash
export BORG_REPO="s3://s3.us-east-1.amazonaws.com/my-bucket/myserver"
export BORG_PASSCOMMAND="echo 'your-strong-passphrase'"
borg init --encryption=repokey $BORG_REPO
```
## 4. Automate Backups Using Systemd Timer or Cron

### Backup Script: `/opt/scripts/linux_backup.sh`
```bash
#!/bin/bash
export BORG_REPO="s3://s3.us-east-1.amazonaws.com/my-bucket/myserver"
export BORG_PASSCOMMAND="echo 'your-strong-passphrase'"

borg create --stats --compression lz4 \
    $BORG_REPO::"backup-{now:%Y-%m-%d_%H-%M}" \
    /etc /home /var /usr/local /opt \
    --exclude /var/tmp --exclude /home/*/.cache

# Prune old backups (keep daily backups for 7 days, weekly for 4 weeks, monthly for 6 months)
borg prune -v $BORG_REPO --keep-daily=7 --keep-weekly=4 --keep-monthly=6

# Compact repository to save space
borg compact $BORG_REPO
```

Make it executable:
```bash
chmod +x /opt/scripts/linux_backup.sh
```

### Schedule via Cron (Daily at Midnight)
```bash
echo "0 0 * * * root /opt/scripts/linux_backup.sh >> /var/log/linux_backup.log 2>&1" | sudo tee /etc/cron.d/linux_backup
```

Or use **systemd timer** for better reliability.

---

## 5. Backup Monitoring & Alerts
- **Log Rotation** (Ensure logs don’t grow too large):
  ```bash
  sudo nano /etc/logrotate.d/linux_backup
  ```
  ```
  /var/log/linux_backup.log {
      weekly
      rotate 5
      compress
      missingok
      notifempty
  }
  ```

- **Email Alerts on Failure**
  Modify the script to send an email if backup fails:
  ```bash
  if [ $? -ne 0 ]; then
      echo "Backup failed on $(hostname) at $(date)" | mail -s "Backup Failed" admin@example.com
  fi
  ```

---

## 6. Disaster Recovery & Restore Testing
To restore files:
```bash
borg list $BORG_REPO  # List backups
borg extract $BORG_REPO::"backup-2025-02-17_00-00" --dry-run
borg extract $BORG_REPO::"backup-2025-02-17_00-00"
```

To restore a single file:
```bash
borg extract $BORG_REPO::"backup-2025-02-17_00-00" etc/nginx/nginx.conf
```

---

## 7. Simulate a System Failure & Restore
1. **Take a fresh backup.**
2. **Delete an important directory (e.g., `/etc`):**
   ```bash
   sudo rm -rf /etc
   ```
3. **Restore it:**
   ```bash
   borg extract $BORG_REPO::"latest"
   ```

---

## Project Deliverables
✅ Backup script with automation (cron/systemd).  
✅ Backup storage on AWS S3.  
✅ Monitoring (logging, email alerts).  
✅ Disaster recovery testing documentation.



#### Install borg on both servers
sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm -y
sudo dnf install -y borgbackup

### On backup server create a directory where backups will be stored 
mkdir -p /mnt/backups/borg-repo

### Initialize Borg repo 
borg init --encryption=repokey /data/backups/borg-repo

##--encryption=repokey ensures encryption of backups using a key stored in the repository.
##You will be prompted for a passphrase to encrypt the backup.

### Setup SSH key for remote backup access borg will communicate over SSH(Generate on client server)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa

### Copy key to destination server 
ssh-copy-id user@destination_server_ip

### Create Backup Script to backup to backup server usng borg 
vi ~/borg.backup.sh
```sh
#!/bin/bash

# Define source and destination directories
SOURCE_DIR=/etc /home /var/log 
DEST_SERVER="david@destination_server_ip"
REPO_DIR="/data/backups/borg-repo"
BACKUP_NAME="backup-$(date +%Y-%m-%d)"

# Run the backup
borg create --compression zlib,6 ssh://$DEST_SERVER/$REPO_DIR::$BACKUP_NAME $SOURCE_DIR

# Prune old backups (keeping the last 3 daily backups, 4 weekly, and 6 monthly)
borg prune --prefix '{hostname}-' --keep-daily=3 --keep-weekly=4 --keep-monthly=6 ssh://$DEST_SERVER/$REPO_DIR
```

### Make script executable 
chmod +x ~/borg-backup.sh

### Run the backup 
~/borg-backup.sh