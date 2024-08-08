#!/bin/bash

read -p "FTP_HOST: " FTP_HOST
read -p "FTP_USER: " FTP_USER
read -p "FTP_PASSWORD: " FTP_PASSWORD
read -p "BackupFile: " BackupFile
read -p "HostDirectory: " HostDirectory
read -p "BackUPPERHOUR (in minutes): " BackUPPERHOUR
cat <<EOL > backupeRF.sh
#!/bin/bash
FTP_HOST="$FTP_HOST"
FTP_USER="$FTP_USER"
FTP_PASSWORD="$FTP_PASSWORD"
LOCAL_FILE="$BackupFile"
REMOTE_DIR="$HostDirectory"
TIMESTAMP=\$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="x-ui_\$TIMESTAMP.db"
lftp -u "\$FTP_USER","\$FTP_PASSWORD" "\$FTP_HOST" <<EOF
set ftp:ssl-allow no
put "\$LOCAL_FILE" -o "\$REMOTE_DIR/\$BACKUP_FILE"
bye
EOF
if [ \$? -eq 0 ]; then
    echo "DONE \$BACKUP_FILE"
else
    echo "Failed"
fi
EOL
chmod +x backupeRF.sh
(crontab -l 2>/dev/null; echo "*/$BackUPPERHOUR * * * * /path/to/backupeRF.sh") | crontab -
