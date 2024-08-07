#!/bin/bash

logfile=/www/logs/php_errors.log
tmpfile=/tmp/err
currenttimestamp=`date +%s`

findalllog(){
   cat $logfile |grep error > $tmpfile
   while read line
   do
       errortimestamp=`echo $line|awk -F '[[ ]' '{print $2,$3}'|xargs -i date -d {} +%s`
       errorlogtime=$(($errortimestamp+60))
       if [ $errorlogtime -ge $currenttimestamp ];then
          /usr/bin/python /opt/soft/dingdingphp.py "$line"
          sleep 1        
       fi   
   done < $tmpfile

}


if [ -e $logfile ];then
   filetimestamp=`stat $logfile |grep Modify|awk '{print $2,$3}'|xargs -i date -d {} +%s`
   tmptime=$(($filetimestamp+60))
   if [ $tmptime -ge $currenttimestamp ];then
      findalllog   
   fi
fi

