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

echo "[U-25] 3.7 NFS 접근 통제" >> $CREATE_FILE 2>&1
echo "[양호] 불필요한 NFS 서비스를 사용하지 않거나, 불가피하게 사용 시 everyone 공유를 제한한 경우" >> $CREATE_FILE 2>&1
echo "[취약] 불필요한 NFS 서비스를 사용하고 있고, 불가피하게 사용 시 everyone 공유를 제한하지 않은 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

NFSCHECK=$(service nfs status)
EXPORTSFILE=/etc/exports

if [[ "$NFSCHECK" == *running* ]]
	then
		echo "NFS 서비스를 사용하고 있습니다." >> $CREATE_FILE 2>&1
		if [ -s $EXPORTSFILE ]
			then
				echo $EXPORTSFILE" 파일 확인이 필요합니다." >> $CREATE_FILE 2>&1
			else
				echo "[취약] NFS 서비스를 사용하고 있고, everyone 공유를 제한하지 않습니다." >> $CREATE_FILE 2>&1
		fi
	else
		echo "[양호] NFS 서비스를 사용하고 있지 않습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

