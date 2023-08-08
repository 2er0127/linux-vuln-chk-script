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

echo "[U-32] 3.14 일반 사용자의 Sendmail 실행 방지" >> $CREATE_FILE 2>&1
echo "[양호] SMTP 서비스 미사용 또는, 일반 사용자의 Sendmail 실행 방지가 설정된 경우" >> $CREATE_FILE 2>&1
echo "[취약] SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않은 경우" >> $CREATE_FILE 2>&1
echo " " >> $CREATE_FILE 2>&1
echo "=======================진단 결과=======================" >> $CREATE_FILE 2>&1

TMPFILE=$(mktemp)

echo `ps -ef | grep sendmail | egrep -v grep` >> $TMPFILE 2>&1
STRCHECK=$(grep -v '^ *#' /etc/mail/sendmail.cf | grep PrivacyOptions)
FILESIZE=$(wc -c "$TMPFILE" | awk '{print $1}')

if [ $FILESIZE -gt 1 ]
	then
		echo "SMTP 서비스를 사용하고 있습니다." >> $CREATE_FILE 2>&1
			if [[ "$STRCHECK" == *authwarnings* ]] && [[ "$STRCHECK" == *novrfy* ]] && [[ "$STRCHECK" == *noexpn* ]] && [[ "$STRCHECK" == *restrictqrun* ]]
				then
					echo "[양호] 일반 사용자의 Sendmail 실행 방지가 설정되어 있습니다." >> $CREATE_FILE 2>&1
				else
					echo "[취약] SMTP 서비스 사용 및 일반 사용자의 Sendmail 실행 방지가 설정되어 있지 않습니다." >> $CREATE_FILE 2>&1
			fi
	else
		echo "[양호] SMTP 서비스를 사용하고 있지 않습니다." >> $CREATE_FILE 2>&1
fi

echo " " >> $CREATE_FILE 2>&1

