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

echo "[U-24] 3.6 NFS 서비스 비활성화" >> $CREATE_FILE 2>&1
echo "[양호] 불필요한 NFS 서비스 관련 데몬이 비활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo "[취약] 불필요한 NFS 서비스 관련 데몬이 활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

NFSCHECK=$(service nfs status)

if [[ "$NFSCHECK" == *running* ]]
	then
		echo "[취약] NFS 서비스 관련 데몬이 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] NFS 서비스 관련 데몬이 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

