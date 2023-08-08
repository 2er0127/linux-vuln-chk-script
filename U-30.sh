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

echo "[U-30] 3.12 Sendmail 버전 점검" >> $CREATE_FILE 2>&1
echo "[양호] Sendmail 버전이 최신 버전인 경우" >> $CREATE_FILE 2>&1
echo "[취약] Sendmail 버전이 최신 버전이 아닌 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TMPFILE=$(mktemp)

echo `ps -ef | grep sendmail | egrep -v grep` >> $TMPFILE 2>&1
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')
SENDMAILSERVICE=$(sendmail -d0.1 < /dev/null | grep -i Version)

if [ $FILESIZE -gt 1 ]
	then
		echo "SMTP 서비스를 사용하고 있습니다." >> $CREATE_FILE 2>&1
		echo $SENDMAILSERVICE >> $CREATE_FILE 2>&1
		echo "*****Sendmail 최신 버전 확인 수동 진단 필요*****" >> $CREATE_FILE 2>&1
		echo "http://www.sendmail.org/" >> $CREATE_FILE 2>&1
	else
		echo "[양호] SMTP 서비스를 사용하고 있지 않습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

