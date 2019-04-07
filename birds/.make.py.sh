#!/bin/sh

NAME=$1

INC=inc
SRC=src
VIM=.vim_commands
COM=":Stdheader\ndd\n:wq"

RD='\033[31m'
CA='\033[36m'
GR='\033[32m'
BL='\033[34m'
PL='\033[35m'
NO='\033[0m'

error() {
	echo -e "${RD}Error: $1${NO}"
}

make_with_vim () {
	if [ -z $1 ] ; then
		error "${RD}NULL parameter passed to ${PL}make_with_vim()"
		return 1
	fi
	echo "${GR}Creating file ${PL}$1"
	vim -s $VIM $1
}

make_dir () {
	if [ -z $1 ] ; then
		error "${RD}NULL parameter passed to ${PL}make_dir()"
		return 1
	fi
	echo "${GR}Creating directory $1"
	mkdir -p $1
}

echo "$COM" >> $VIM

make_dir $SRC
make_dir $INC

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

make_with_vim $SRC/$NAME.py
echo "def main():" >> $SRC/$NAME.py
echo "\tprint 'Hello World!'\n" >> $SRC/$NAME.py
echo "if __name__ == '__main__':" >> $SRC/$NAME.py
echo "\tmain()" >> $SRC/$NAME.py

touch $INC/config

rm $VIM