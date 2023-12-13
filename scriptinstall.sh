#!/bin/bash

ID=$(id -u)

if [ $ID != 0 ]
then
    echo "Error: Please run the script with root user"
else
    echo "You are a root user"

fi
yum install mysql -y
