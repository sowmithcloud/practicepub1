#!/bin/bash

SOURCE_DIR=""
DESTINATION_DIR=""
ACTION=""
DAYS=14
MEMORY=""

USAGE(){

    echo "COMMAND USAGE: $(basename $0) -s <Source Directory> -d <Destination Directory> -a <action: delete or archive> -t <No.of Days> -m <Memory size of file>"
    echo "Options: "
    echo " -s: Specify the source directory"
    echo " -d: Specify the destination directory when -a is archive"
    echo " -t: Number of days back to delete log file"
    echo " -m: Memory size of the file to delete log file"
    echo " -a: Action to be performed on log files. Options : Delete or Archive"
    echo " -h: Display Help and exit"
    
}


while getopts ":s:a:d:t:m" options
do
    case $options in
        s) SOURCE_DIR="$OPTARG";;
        d) DESTINATION_DIR="$OPTARG";;
        a) ACTION="$OPTARG";;
        t) DAYS="$OPTARG";;
        m) MEMORY="$OPTARG";;
        h) USAGE; exit;;
        \?) echo "Invalid option: -"$OPTARG"" >&2; USAGE; exit 1;;

    esac

done

if [ -z "$SOURCE_DIR" ] || [ -z "$ACTION" ]
then
    echo "options -s and -a are madatory"
    USAGE
fi

if [ "$ACTION" != "archive" ] && [ "$ACTION" != "delete" ]
then
    echo "selecting archive or delete is mandatory"
    USAGE
fi

if [ "$ACTION" == "archive" ] && [ -z "$DESTINATION_DIR" ]
then
    echo "Destination directory is madatory when you select archive"
    USAGE

fi

if [ "$ACTION" == "delete" ]
then
    FILES_TO_DELETE=$(find $SOURCE_DIR -type f -mtime $DAYS -name "*.log")

    while IFS= read -r line
    do
        echo "Deleting the file: $line"
        rm -f "$line"
    
    done <<< $FILES_TO_DELETE

else

    FILES_TO_ARCHIVE=$(find $SOURCE_DIR -type f -mtime +"$DAYS" -name "*.log")

    while IFS= read -r line
    do
        echo "Archiving file: $line"
        zip -r "$DESTINATION_DIR/$(basename "$line").zip"
        rm -rf $line
    done <<< $FILES_TO_ARCHIVE

fi
