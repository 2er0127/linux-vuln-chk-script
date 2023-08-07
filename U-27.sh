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

echo "[U-27] 3.9 RPC 서비스 확인" >> $CREATE_FILE 2>&1
echo "[양호] 불필요한 RPC 서비스가 비활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo "[취약] 불필요한 RPC 서비스가 활성화 되어 있는 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TMPFILE=$(mktemp)

echo `ps -ef | egrep "rpc.cmsd|rpc.ttdbserverd|sadmind|rusersd|walld|sparyd|rstatd|rpc.nisd|rpc.pcnfsd|rpc.statd|rpc.ypupdated|rpc.rqoutad|kcms_server|chackefsd|rexd" | egrep -v grep` >> $TMPFILE 2>&1
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')
RPCSERVICENAME=$(ps -ef | egrep "rpc.cmsd|rpc.ttdbserverd|sadmind|rusersd|walld|sparyd|rstatd|rpc.nisd|rpc.pcnfsd|rpc.statd|rpc.ypupdated|rpc.rqoutad|kcms_server|chackefsd|rexd" | egrep -v grep | awk '{print $8}')

if [ $FILESIZE -gt 1 ]
	then
		echo "[취약] RPC 서비스가 활성화 되어 있습니다." >> $CREATE_FILE 2>&1
		echo "process: "$RPCSERVICENAME >> $CREATE_FILE 2>&1
	else
		echo "[양호] RPC 서비스가 비활성화 되어 있습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

