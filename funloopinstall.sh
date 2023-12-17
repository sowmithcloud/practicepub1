#!/bin/bash

ID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"

TIMESTAMP=$date
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "Script executing started at $TIMESTAMP" &>> $LOGFILE

validate(){

    if [ $1 != 0 ]
    then
        echo -e "$2...$R failed $N"
    else
        echo -e "$2...$G success $N"
    fi
}


if [ $ID != 0 ]
then
    echo "Error: you are not a root user"
    exit 1
else
    echo "you are root user"
fi

for package in $@
do
    yum list installed $package -y &>> $LOGFILE
    
    if [ $? != 0 ]
    then
        yum install $package -y &>> $LOGFILE
        validate $? "installation of $package"
    else
        echo "$package is already installed so skipping installation"
    if
done