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

echo "[U-29] 3.11 tftp, talk 서비스 비활성화" >> $CREATE_FILE 2>&1
echo "[양호] tftp, talk, ntalk 서비스가 비활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo "[취약] tftp, talk, ntalk 서비스가 활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TFTPCHECK=$(chkconfig --list | egrep tftp | awk '{print $2}')
TALKCHECK=$(chkconfig --list | egrep talk | awk '{print $2}')
NTALKCHECK=$(chkconfig --list | egrep ntalk | awk '{print $2}')
VULNSERVICENAME=$(chkconfig --list | egrep "tftp|talk|ntalk" | grep on | awk '{print $1}' | sed 's/://g')

if [ $TFTPCHECK == 'on' ] || [ $TALKCHECK == 'on' ] || [ $NTALKCHECK == 'on' ]
	then
		echo "[취약] "$VULNSERVICENAME" 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] tftp, talk, ntalk 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

