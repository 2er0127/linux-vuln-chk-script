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

echo "[U-21] 3.3 r 계열 서비스 비활성화" >> $CREATE_FILE 2>&1
echo "[양호] 불필요한 r 계열 서비스가 비활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo "[취약] 불필요한 r 계열 서비스가 활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

RSHCHECK=$(chkconfig --list | egrep rsh | awk '{print $2}')
RLOGINCHECK=$(chkconfig --list | egrep rlogin | awk '{print $2}')
REXECCHECK=$(chkconfig --list | egrep rexec | awk '{print $2}')
VULNSERVICENAME=$(chkconfig --list | egrep "rsh|rlogin|rexec" | grep on | awk '{print $1}' | sed 's/://g')

if [ $RSHCHECK == 'on' ] || [ $RLOGINCHECK == 'on' ] || [ $REXECCHECK == 'on' ]
	then
		echo "[취약] "$VULNSERVICENAME" 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] r 계열 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1



