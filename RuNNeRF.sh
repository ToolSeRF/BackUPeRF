#!/bin/bash
sudo apt install -y lftp
read -p "FTP_HOST: " FTP_HOST
read -p "FTP_USER: " FTP_USER
read -p "FTP_PASSWORD: " FTP_PASSWORD
read -p "BackupFile: " BackupFile
read -p "HostDirectory: " HostDirectory
read -p "Back UP in HOURs: " BackUPPERHOUR
read -p "Backup File Prefix Name: " PRFNM
read -p "Bot Token: " MYBOTTOKEN
read -p "Your ChatID: " MYBOTCHATID
read -p "Your Backup Directory Example: /home/username/public_html/backup/ : " MYBACKUPDIR
read -p "Bot Domain And Path example: ss.com/backup/" MYBOTDOM
random_filename=$(tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 12)
php_file_path="/root/${random_filename}.php"
cat <<EOL > "$php_file_path"
<?php
\$token = "$MYBOTTOKEN";
\$chat_id = "$MYBOTCHATID";
\$directory = '$MYBACKUPDIR';
\$logFile = 'log.txt';
function logMessage(\$message) {
    global \$logFile;
    \$timestamp = date('Y-m-d H:i:s');
    file_put_contents(\$logFile, "[\$timestamp] \$message" . PHP_EOL, FILE_APPEND);
}

logMessage("Starting script...");

\$files = array_filter(scandir(\$directory), function(\$file) use (\$directory) {
    return pathinfo(\$file, PATHINFO_EXTENSION) === 'db' && 
           is_file("\$directory/\$file") && 
           strpos(\$file, '$PRFNM') === 0; 
});

if (empty(\$files)) {
    logMessage("No .db files starting with '$PRFNM' found.");
} else {
    usort(\$files, function(\$a, \$b) use (\$directory) {
        return filemtime("\$directory/\$b") - filemtime("\$directory/\$a");
    });
    \$latestFile = \$files[0]; 
    logMessage("Found latest file: \$latestFile");
    
    \$filePath = "\$directory/\$latestFile";
    if (!file_exists(\$filePath)) {
        logMessage("File does not exist: \$filePath");
    } else {
        \$result = sendFileToTelegram(\$token, \$chat_id, \$filePath);
        logMessage("Telegram API response: \$result");
        
        if (\$result === false || json_decode(\$result)->ok !== true) {
            logMessage("Failed to send file: \$filePath");
        } else {
            logMessage("Successfully sent file: \$filePath");
        }
    }
}

function sendFileToTelegram(\$token, \$chat_id, \$filePath) {
    \$url = "https://api.telegram.org/bot\$token/sendDocument";

    \$postFields = [
        'chat_id' => \$chat_id,
        'document' => new CURLFile(realpath(\$filePath))
    ];
    
    \$ch = curl_init();
    curl_setopt(\$ch, CURLOPT_URL, \$url);
    curl_setopt(\$ch, CURLOPT_POST, true);
    curl_setopt(\$ch, CURLOPT_POSTFIELDS, \$postFields);
    curl_setopt(\$ch, CURLOPT_RETURNTRANSFER, true);
    
    \$result = curl_exec(\$ch);
    if (curl_errno(\$ch)) {
        logMessage('CURL error: ' . curl_error(\$ch));
    }
    
    curl_close(\$ch);
    return \$result;
}
?>
EOL

echo "'$random_filename.php' in '$php_file_path' Created."

lftp -u "$FTP_USER","$FTP_PASSWORD" "$FTP_HOST" <<EOF
set ftp:ssl-allow no
put "$php_file_path" -o "$HostDirectory/$random_filename.php"
bye
EOF

if [ $? -eq 0 ]; then
    echo "Bot PHP File Uploaded Done"
else
    echo "Bot PHP File Not Transfer"
fi

cat <<EOL > /etc/backUPeRF.sh
#!/bin/bash
FTP_HOST="$FTP_HOST"
FTP_USER="$FTP_USER"
FTP_PASSWORD="$FTP_PASSWORD"
LOCAL_FILE="$BackupFile"
REMOTE_DIR="$HostDirectory"
TIMESTAMP=\$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${PRFNM}\$TIMESTAMP.db"
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

chmod +x /etc/backUPeRF.sh
(crontab -l 2>/dev/null; echo "0 */$BackUPPERHOUR * * * /etc/backUPeRF.sh") | crontab -
sudo /etc/backUPeRF.sh
wget https://api.telegram.org/bot$MYBOTTOKEN/setwebhook?url=https://$MYBOTDOM$random_filename.php
(crontab -l; echo "0 */$BackUPPERHOUR * * * /etc/backUPeRF.sh"; echo "1 */$BackUPPERHOUR * * * wget -q https://$MYBOTDOM$random_filename.php -O /dev/null") | crontab -

wget https://$MYBOTDOM$random_filename.php && clear

