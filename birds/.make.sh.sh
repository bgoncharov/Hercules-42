#!/bin/sh

NAME=$1

RD='\033[31m'
CA='\033[36m'
GR='\033[32m'
BL='\033[34m'
PL='\033[35m'
NO='\033[0m'

error() {
	echo -e "${RD}Error: $1${NO}"
}

echo "\n${BL}Would you like to add .gitignore?"
echo "\t${CA}[1]$NO yes"
echo "\t${CA}[2]$NO no"
read TYPE
if [ "$TYPE" -eq "1" ] ; then
	echo "${GR}Creating file ${PL}.gitignore"
	touch .gitignore
elif [ "$TYPE" -ne "2" ] ; then
	error "${CA}$TYPE${RD} is not a valid response."
fi

touch $NAME.sh
echo "#!/bin/sh\n" > $NAME.sh
echo "whoami" >> $NAME.sh