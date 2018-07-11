#!/bin/bash
#CODEDBYALCHADECODE

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
printf "   $YELLOW		          BASH EMAIL FILTER				\n"
printf "   $WHI ============================================================ \n"
printf "\n"
printf "   $YELLOW		   	    -AlchaDecode-				\n"
printf "   $WHI ============================================================ \n"
printf "$NC\n"

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
echo ""
totalLines=`grep -c "@" $inputFile`
printf "$YELLOW Detected $totalLines email in $inputFile\n"
printf "$YELLOW Cleaning $inputFile from duplicate email and another string\n"
# Code for cleaning email list
grep -Eiorh '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})' $inputFile | sort | uniq > temp_list && mv temp_list $inputFile
# Lowering the word
cat $inputFile | awk '{print tolower($0)}' | sort | uniq > temp_list && mv temp_list $inputFile
# Removing duplicates line
sort -u $inputFile | uniq > temp_list && mv temp_list $inputFile

google=(@gmail @google @googlemail)
microsoft=(@live @outlook @hotmail @msn)
yahoo=(@rocketmail @yahoo @ymail @bt @sky @btinternet)
aol=(@aol.com)
sgmail='gmail_fams.txt'
smicrosoft='microsoft_fams.txt'
syahoo='yahoo_fams.txt'
saol='aol_fams.txt'
sother='other.txt'
cp $inputFile $targetFolder/$sother
for (( i = 0; i < ${#google[@]}; i++ )); do
a=$(cat $inputFile | grep ${google[$i]});
printf "$a\n" >> $targetFolder/$sgmail
cat "$targetFolder/$sother" | grep -v ${google[$i]} | sort | uniq > "$targetFolder/tmp_other" && mv "$targetFolder/tmp_other" "$targetFolder/$sother"
done
for (( i = 0; i < ${#microsoft[@]}; i++ )); do
a=$(cat $inputFile | grep ${microsoft[$i]});
printf "$a\n" >> $targetFolder/$smicrosoft
cat "$targetFolder/$sother" | grep -v ${microsoft[$i]} | sort | uniq > "$targetFolder/tmp_other" && mv "$targetFolder/tmp_other" "$targetFolder/$sother"
done
for (( i = 0; i < ${#yahoo[@]}; i++ )); do
a=$(cat $inputFile | grep ${yahoo[$i]});
printf "$a\n" >> $targetFolder/$syahoo
cat "$targetFolder/$sother" | grep -v ${yahoo[$i]} | sort | uniq > "$targetFolder/tmp_other" && mv "$targetFolder/tmp_other" "$targetFolder/$sother"
done
for (( i = 0; i < ${#aol[@]}; i++ )); do
a=$(cat $inputFile | grep ${aol[$i]});
printf "$a\n" >> $targetFolder/$saol
cat "$targetFolder/$sother" | grep -v ${aol[$i]} | sort | uniq > "$targetFolder/tmp_other" && mv "$targetFolder/tmp_other" "$targetFolder/$sother"
done
totgm=`grep -c "@" $targetFolder/$sgmail`
totmic=`grep -c "@" $targetFolder/$smicrosoft`
totya=`grep -c "@" $targetFolder/$syahoo`
totao=`grep -c "@" $targetFolder/$saol`
totot=`grep -c "@" $targetFolder/$sother`
echo ""
printf "$YELLOW Gmail     = $totgm Detected\n"
printf "$YELLOW Microsoft = $totmic Detected\n"
printf "$YELLOW Yahoo     = $totya Detected\n"
printf "$YELLOW Aol       = $totao Detected\n"
printf "$YELLOW Other     = $totot Detected\n"
echo ""
printf "$YELLOW Filtering Process Done\n"
