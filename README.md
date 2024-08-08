BackUPeRF is a backup script for a specific file on the Ubuntu operating system to a host via FTP.

First, run the script RuNNeRF.sh.

Enter the host address and login credentials.
Choose the path of the file you want to back up, for example, /etc/x.db.
Specify the file path on the host; it's very important that this path exists on the host, for example, /public_html/.

After entering the above information, the script will create a file named backupeRF.sh for you. 
Additionally, a cron job will be set up based on the specified hour for automatic backups.

This is a simple and practical script for automatically backing up your desired files to the host.
