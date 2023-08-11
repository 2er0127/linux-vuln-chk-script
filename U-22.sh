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

echo "[U-22] 3.4 crond 파일 소유자 및 권한 설정" >> $CREATE_FILE 2>&1
echo "[양호] crontab 명령어 일반사용자 금지 및 cron 관련 파일 640 이하인 경우" >> $CREATE_FILE 2>&1
echo "[취약] crontab 명령어 일반사용자 사용가능하거나, crond 관련 파일 640 이상인 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

FILENAME1='/usr/bin/crontab'
FILENAME2='/etc/crontab'
FILEPRINT1=$(ls -al /usr/bin/crontab)
FILEPRINT2=$(ls -al /etc/crontab)

PERMCHECK1=$(find $FILENAME1 -perm 640)
if [ -n "$PERMCHECK1" ]
	then
        echo $FILENAME1 "파일은 [양호] crontab 명령어 일반사용자 금지 및 crond 관련 파일 권한이 640 입니다." >> $CREATE_FILE 2>&1
else   
		echo $FILENAME1 "파일은 [취약] crontab 명령어 일반사용자 사용가능하거나, crond 관련 파일 권한이 640 이상입니다." >> $CREATE_FILE 2>&1
		echo $FILEPRINT1 >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

PERMCHECK2=$(find $FILENAME2 -perm 640)
if [ -n "$PERMCHECK2" ]
	then
        echo $FILENAME2 "파일은 [양호] crontab 명령어 일반사용자 금지 및 crond 관련 파일 권한이 640 입니다." >> $CREATE_FILE 2>&1
else   
		echo $FILENAME2 "파일은 [취약] crontab 명령어 일반사용자 사용가능하거나, crond 관련 파일 권한이 640 이상입니다." >> $CREATE_FILE 2>&1
		echo $FILEPRINT2 >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1



