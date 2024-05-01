#!/bin/bash

mkdir /etc/vsftpd.user_list
sed -i '/^root/s/^/#/' /etc/ftpusers

chmod 777 /home/kzegani

service vsftpd reload

vsftpd