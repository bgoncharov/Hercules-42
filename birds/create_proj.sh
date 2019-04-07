#!/bin/bash

CUR_FL_DIR="`dirname \"$0\"`"
SCRIPT="`cd \"$CUR_FL_DIR\" ; pwd -P `"

GIT=.git

RD='\033[0;31m'
GR='\033[0;32m'
YL='\033[0;33m'
BL='\033[0;34m'
PL='\033[0;35m'
CY='\033[0;36m'
NO='\033[0m'

error() {
	echo -e "${RD}Error: $1${NO}"
}

make_dir () {
	if [ -z "$1" ] ; then
		error "NO parameter for ${GR}make_dir()"
		return 1
	fi
	mkdir -p "$1"
	echo "${GR}Directory created ${BL}$1"
}

echo "${NO}What is the name of the project?"
read NAME

if [ -z "$NAME" ] ; then
	error "The name of the project cannot be NULL."
	exit

elif [ -d "$NAME" ] ; then
	error "A directory ${RD}$NAME${RD} already exists."
	exit

elif [ -f "$NAME" ] ; then
	error "A file ${RD}$NAME${RD} already exists."
	exit
fi

echo "${GR}Initializing git repository."
git init "$NAME"

echo "${GR}Entering repository."
cd "$NAME"

echo "\n${BL}What kind of project is $NAME?"
echo "${BL}(For example: ${GR}c${BL}, ${GR}py${BL}, ${GR}sh${BL}...)$NO"
read TYPE

if [ -n "$TYPE" ] ; then
	if [ -f "$SCRIPT/.make.$TYPE.sh" ] ; then
		echo "${BL}Prepearing a ${GR}$TYPE${BL} project for you..${NO}"
		sh "$SCRIPT/.make.$TYPE.sh" "$NAME" "$GIT"
	else
		echo "${RD}Unkwon projct type $TYPE${NO}"
	fi

else
	echo "${BL}Skipping..$N"
fi

echo "${GR}Adding files to git and make first commit."
git add *
git status
git commit -m "Initial commit"
echo "${GR}Finished${NO}"
