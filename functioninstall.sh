#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"

TIMESTAMP=$date
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "Script started executing at $TIMESTAMP" &>> $LOGFILE

validate(){
    if [ $1 != 0 ]
    then
        echo "Error: $2 failed"
        exit 1
    else
        echo "$2 success"
    fi
}

if [ $ID != 0 ]
then
    echo "Error: run the script as root user"
    exit 1
else
    echo "You are a root user"
fi

yum install mysql -y &>> $LOGFILE
validate $? "Intalling mysql"

yum install tree -y &>> $LOGFILE
validate $? "Intalling tree"