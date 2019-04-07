#!/bin/sh

NAME=$1
GIT=$2

LIB=libft
LDIR=~/Desktop/projects
INC=inc
SRC=src
MAKE=Makefile

VIM=.vim_commands

COM=":Stdheader\ndd\n:wq"

RD='\033[31m'
CA='\033[36m'
GR='\033[32m'
BL='\033[34m'
PL='\033[35m'
NO='\033[0m'

error () {
	echo "${RD}Error: $1${NO}"
}

make_dir () {
	if [ -z $1 ] ; then
		error "NULL parameter passed to ${RD}make_dir()"
		return 1
	fi
	echo "${GR}Creating directory ${PL}$1"
	mkdir -p $1
}

make_with_vim () {
	if [ -z $1 ] ; then
		error "NULL parameter passed to ${RD}make_with_vim()"
		return 1
	fi
	echo "${GR}Creating file ${PL}$1"
	vim -s $VIM $1
}

add_line () {
	echo "$1" >> $MAKE
}

insert_at () {
	head -n $2 $MAKE > .temp$MAKE
	echo "$1\c" >> .temp$MAKE
	tail -n +$2 $MAKE >> .temp$MAKE
	mv .temp$MAKE $MAKE
}

add_lib () {
	if [ ! -d $LDIR/$LIB ] ; then
		error "Directory was not found at ${RD}$LDIR/$LIB"
		return 1
	fi
	if [ -d ./$LIB ] ; then
		error "${RD}Library ${PL}$LIB ${RD}already exists in this directory."
		return 1
	fi
	ln -s "$LDIR/$LIB" "$LIB"
	echo "${GR}Adding necessary lines to $MAKE"
	NLIB=$(echo $LIB | awk '{print toupper($0)}')
	add_line "\n\$($NLIB):"
	add_line "\t@\$(MAKE) -C \$(${NLIB}_DIR)"
	insert_at "" 20
	insert_at "$NLIB=\$(${NLIB}_DIR)/\$(${NLIB}_LIB)" 20
	insert_at "${NLIB}_LIB=$LIB.a" 20
	insert_at "${NLIB}_DIR=$LIB" 20
	sed -i '' -e "s|I $INC|I \$(${NLIB}_DIR)/\\\$(${NLIB}_INC) -I $INC|" $MAKE
	sed -i '' "s/^all: /all: \$($NLIB) /" $MAKE
	sed -i '' "s/^clean:/clean:\\
	@make -C \$(${NLIB}_DIR) clean/" $MAKE
	sed -i '' "s/^fclean: clean/fclean: clean\\
	@make -C \$(${NLIB}_DIR) fclean/" $MAKE
	sed -i '' "s/\$(CC) \$(FLAGS)/\$(CC) \$(FLAGS) \$(${NLIB})/" $MAKE
}

echo "$COM" >> $VIM

make_dir $SRC
make_dir $INC

touch .gitignore
echo "${GR}Creating file ${PL}.gitignore"
echo "*.o" >> .gitignore
echo "*.a" >> .gitignore

touch author
echo "bogoncha" >> author

make_with_vim $INC/$NAME.h
echo "#ifndef $(echo $NAME | awk '{print toupper($0)}')_H" >> $INC/$NAME.h
echo "# define $(echo $NAME | awk '{print toupper($0)}')_H" >> $INC/$NAME.h
echo "\n\n\n#endif" >> $INC/$NAME.h

make_with_vim $SRC/main.c
echo "#include \"$NAME.h\"\n\nint\t\t\tmain(int argc, char **argv)" >> $SRC/main.c
echo "{\n\t(void)argc;\n\t(void)argv;\n\treturn (0);\n}" >> $SRC/main.c

make_with_vim $MAKE
add_line "NAME=$NAME\n"
add_line "CC=gcc"
add_line "CFLAGS=-Wall -Werror -Wextra"
add_line "SRC_DIR=$SRC"
add_line "SRCS=\$(SRC_DIR)/*.c"
add_line "OBJ=\$(SRC_DIR)/*.o\n"
add_line "all: \$(NAME)\n"
add_line "\$(NAME):"
add_line "\t\$(CC) \$(FLAGS) \$(OBJS) -o \$(NAME)\n"
add_line "clean:"
add_line "\t@rm -rf \$(OBJ_DIR)\n"
add_line "fclean: clean"
add_line "\t@rm -f \$(NAME)\n"
add_line "re: fclean all"

echo "\n${BL}Would you like to include ${PL}$LIB$W ${BL}from ${PL}$LDIR${NO} ?"
echo "\t${CA}[1]$W yes"
echo "\t${CA}[2]$W no"
read TYPE
if [ "$TYPE" -eq "1" ] ; then
	add_lib
elif [ "$TYPE" -ne "2" ] ; then
	error "${CA}$TYPE${R} is not a valid response."
fi

rm $VIM
