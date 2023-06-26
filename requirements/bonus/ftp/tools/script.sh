#!/bin/sh
if [ ! -f /var/run/vsftpd/empty ]; then
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty
useradd -m -p $(openssl passwd -1 $FTP_PASS) $FTP_USER

echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

/usr/sbin/vsftpd /etc/vsftpd.conf