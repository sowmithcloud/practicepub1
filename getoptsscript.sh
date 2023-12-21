#!/bin/bash

NAME=""
WISHES=""

USAGE() {

    echo "USAGE: $(basename $0) -n <name> -w <wishes>"
    echo "Options::"
    echo "-n , specify name for this option"
    echo "-w , specify wish for this option"
    echo "-h , for help or suggestion"
}


while getopts "n:w:h" options
do
    case $options in
        n) NAME="$OPTARG";;
        w) WISHES="$OPTARG";;
        h|*) USAGE;
    esac

done

if [ -z $NAME ] || [ -z $WISHES ]
then
echo "Options -n and -w are mandatory"
fi

echo "$NAME , $WISHES"