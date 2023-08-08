#!/bin/sh

LANG=C
export LANG
alias ls=ls

CREATE_FILE=`hostname`"-"`date +%m%d`.txt

# root check
if [ "$EUID" -ne 0 ]
	then
		echo "root 권한이 필요합니다."
	exit
fi

echo "====================================================" >> $CREATE_FILE 2>&1
echo "*              linux_script version0.1             *" >> $CREATE_FILE 2>&1
echo "====================================================" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "---------------------start time---------------------" >> $CREATE_FILE 2>&1
date >> $CREATE_FILE 2>&1
echo "----------------------------------------------------" >> $CREATE_FILE 2>&1
cat /etc/redhat-release >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "####################################################" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1

echo "[U-28] 3.10 NIS, NIS+ 점검" >> $CREATE_FILE 2>&1
echo "[양호] NIS 서비스가 비활성화 되어 있거나, 필요 시 NIS+를 사용하는 경우" >> $CREATE_FILE 2>&1
echo "[취약] NIS 서비스가 활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TMPFILE=$(mktemp)

echo `ps -ef | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd|rpc.ypupdated" | egrep -v grep` >> $TMPFILE 2>&1
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')
NISSERVICENAME=$(ps -ef | egrep "ypserv|ypbind|ypxfrd|rpc.yppasswdd|rpc.ypupdated" | egrep -v grep | awk '{print $8}')

if [ $FILESIZE -gt 1 ]
	then
		echo "[취약] NIS 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
		echo "process: "$NISSERVICENAME >> $CREATE_FILE 2>&1
	else
		echo "[양호] NIS 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

