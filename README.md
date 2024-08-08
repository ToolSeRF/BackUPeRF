<code>bash <(curl -s https://raw.githubusercontent.com/ToolSeRF/BackUPeRF/main/RuNNeRF.sh --ipv4)</code>

BackUPeRF is a backup script for a specific file on the Ubuntu operating system to a host via FTP.

First, run the script RuNNeRF.sh.

Enter the host address and login credentials.
Choose the path of the file you want to back up, for example, /etc/x.db.
Specify the file path on the host; it's very important that this path exists on the host, for example, /public_html/.

After entering the above information, the script will create a file named BackUPeRF.sh for you. 
Additionally, a cron job will be set up based on the specified hour for automatic backups.

This is a simple and practical script for automatically backing up your desired files to the host.


BackUPeRF یک اسکریپت بک آپ از یک فایل مشخص در سیستم عامل ابونتو به هاست از طریق FTP است

ابتدا اسکریپت RuNNeRF.sh را اجرا کنید

آدرس هاست و مشخصات ورود را ثبت کنید
مسیر فایلی که میخواهید برایتان بک آپ گرفته شود را انتخاب کنید برای مثال /etc/x.db
مسیر فایل در هاست را مشخص کنید، بسیار مهم است که این مسیر در هاست وجود داشته باشد برای مثال /public_html/
همچنین می توانید اسم دلخواه برای فایل بک آپ در هاست ایجاد کنید
پس از وارد کردن اطلاعات بالا اسکریپت یک فایل با اسم BackUPeRF.sh برای شما ایجاد میکند
همچنین  کرون جاب با توجه به مقدار ساعت مشخص شده برای دریافت بک آپ اتوماتیک تنظیم خواهد شد.


این یک اسکریپت ساده و کاربردی برای دریافت بک آپ اتوماتیک از فایل های دلخواهتان بر روی هاست است.
