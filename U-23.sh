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

echo "[U-23] 3.5 DoS 공격에 취약한 서비스 비활성화" >> $CREATE_FILE 2>&1
echo "[양호] 사용하지 않는 DoS 공격에 취약한 서비스가 비활성화 된 경우" >> $CREATE_FILE 2>&1
echo "[취약] 사용하지 않는 DoS 공격에 취약한 서비스가 활성화 된 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

CHARGENCHECK1=$(cat /etc/xinetd.d/chargen-dgram | grep disable | awk '{print $3}')
CHARGENCHECK2=$(cat /etc/xinetd.d/chargen-stream | grep disable | awk '{print $3}')
DAYTIMECHECK1=$(cat /etc/xinetd.d/daytime-dgram | grep disable | awk '{print $3}')
DAYTIMECHECK2=$(cat /etc/xinetd.d/daytime-stream | grep disable | awk '{print $3}')
DISCARDCHECK1=$(cat /etc/xinetd.d/discard-dgram | grep disable | awk '{print $3}')
DISCARDCHECK2=$(cat /etc/xinetd.d/discard-stream | grep disable | awk '{print $3}')
ECHOCHECK1=$(cat /etc/xinetd.d/echo-dgram | grep disable | awk '{print $3}')
ECHOCHECK2=$(cat /etc/xinetd.d/echo-stream | grep disable | awk '{print $3}')

if [ $CHARGENCHECK1 == 'no' ] || [ $CHARGENCHECK2 == 'no' ]
	then
		echo "[취약] chargen 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] chargen 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

if [ $DAYTIMECHECK1 == 'no' ] || [ $DAYTIMECHECK2 == 'no' ]
	then
		echo "[취약] daytime 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] daytime 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

if [ $DISCARDCHECK1 == 'no' ] || [ $DISCARDCHECK2 == 'no' ]
	then
		echo "[취약] discard 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] discard 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

if [ $ECHOCHECK1 == 'no' ] || [ $ECHOCHECK2 == 'no' ]
	then
		echo "[취약] echo 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
	else
		echo "[양호] echo 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

