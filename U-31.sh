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

echo "[U-31] 3.13 스팸 메일 릴레이 제한" >> $CREATE_FILE 2>&1
echo "[양호] SMTP 서비스를 사용하지 않거나 릴레이 제한이 설정되어 있는 경우" >> $CREATE_FILE 2>&1
echo "[취약] SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않은 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TMPFILE=$(mktemp)
TMPFILE2=$(mktemp)

echo `ps -ef | grep sendmail | egrep -v grep` >> $TMPFILE 2>&1
echo `cat /etc/mail/sendmail.cf | grep "R$\*" | grep "Relaying denied"` >> $TMPFILE2 2>&1
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')
FILESIZE2=$(wc -c "$TMPFILE2" | awk '{print $1}')

if [ $FILESIZE -gt 1 ]
	then
		echo "SMTP 서비스를 사용하고 있습니다." >> $CREATE_FILE 2>&1
			if [ $FILESIZE2 -gt 1 ]
				then
					echo "[양호] 릴레이 제한이 설정되어 있습니다." >> $CREATE_FILE 2>&1
				else
					echo "[취약] SMTP 서비스를 사용하며 릴레이 제한이 설정되어 있지 않습니다." >> $CREATE_FILE 2>&1
			fi
	else
		echo "[양호] SMTP 서비스를 사용하고 있지 않습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

