![image](https://github.com/user-attachments/assets/9715e8d3-397d-4ada-9e85-b81df5b40c75)

<code>bash <(curl -s https://raw.githubusercontent.com/ToolSeRF/BackUPeRF/main/RuNNeRF.sh --ipv4)</code>

BackUPeRF is a simple and practical script for taking backups from an Ubuntu server and sending them to a Telegram bot.

First, run the script on the server using the following command:

- **"FTP_HOST:"** Enter your host name.
- **"FTP_USER:"** Enter your host username.
- **"FTP_PASSWORD:"** Enter your host password.
- **"BackupFile:"** Enter the path and file for the backup, for example, /etc/x.db.
- **"HostDirectory:"** Enter the directory on the host, for example, /public_html/nifo/.
- **"Back UP in HOURS:"** Enter the periodic backup time in hours.
- **"Backup File Prefix Name:"** Enter a default name for the backup file, for example, DubaiServ.
- **"Bot Token:"** Enter your bot token.
- **"Your ChatID:"** Enter the chat ID of the bot administrator.
- **"Your Backup Directory Example: /home/username/public_html/nifo/:** Enter the address of the backup file directory.
- **"Bot Domain And Path example: ss.com/nifo/":** Enter the domain and directory path of the files.

After entering the above information, the script will create a file named backUPeRF.sh in the /etc/ directory. It will then set up the Telegram API and run once to verify its functionality. Additionally, a cron job will be created to schedule the backup process and transfer it to Telegram based on the hour you specified

![image](https://github.com/user-attachments/assets/cedc0c16-b6b8-47b5-a90f-58454f7fad59)


BackUPeRF یک اسکریپت ساده و کاربردی برای دریافت بک آپ از سرور ابونتو به هاست و ارسال آن به بات تلگرام می باشد

ابتدا اسکریپت را از طریق دستور زیر در سرور اجرا کنید

"FTP_HOST: " نام هاست خود را وارد کنید
"FTP_USER: " نام کاربری هاست را وارد کنید
"FTP_PASSWORD: " رمز عبور هاست را وارد کنید
 "BackupFile: " مسیر و فایل بک آپ را وارد کنید برای مثال /etc/x.db
"HostDirectory: " دایرکتوری هاست را وارد کنید برای مثال /public_html/nifo/
"Back UP in HOURs: " زمان بک آپ گیری دوره ای بر اساس ساعت را وارد کنید
"Backup File Prefix Name: " یک اسم پیش فرض برای فایل بک آپ وارد کنید مثلا DubaiServ
"Bot Token: " توکن بات خود را وارد کنید
"Your ChatID: " چت ای دی مدیر بات را وارد کنید
 "Your Backup Directory Example: /home/username/public_html/nifo/ : " آدرس دایرکتوری فایل بک آپ را وارد کنید
"Bot Domain And Path example: ss.com/nifo/"  آدرس دامنه و دایرکتوری فایل ها را وارد کنید



پس از ورود اطلاعات بالا اسکریپت برای شما یک فایل با اسم backUPeRF.sh در مسیر /etc/ ایجاد میکند
سپس api تلگرام ست و یک بار اجرا می شود تا از صحت کارکرد آن مطلع شوید
همچنین یک کرون جاب برای تنظیم بک آپ گیری و انتقال آن به تلگرام در سرور نوشته می شود و بر اساس ساعتی که وارد کرده اید بک آپ گیری انجام و در بات تلگرام آپلود می شود
