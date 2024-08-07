#!/bin/bash
##**************************************************
##filename      : check_sql_error.sh
##author        : JvvYou                               
##create time   : 2019-08-07 11:17:38
##last modified : 2019-08-07 11:17:38
##description   : NA                                
##*************************************************

commondir=/www/logs/
filename=mysql_debug_content.log
currenttimestamp=`date +%s`

year=`date +%Y-%m-%d|awk -F '-' '{print $1}'`
mon=`date +%Y-%m-%d|awk -F '-' '{print $2}'`
day=`date +%Y-%m-%d|awk -F '-' '{print $3}'`
file=$commondir$year$mon/$year$mon$day/$filename

findalllog(){

  while read line
  do 
    sqltimestamp=`echo "$line"|awk -F ': {' '{print $1}'|xargs -i date -d {} +%s`
    errorlogtime=$(($sqltimestamp+60))
    if [ $errorlogtime -ge $currenttimestamp ];then
       /opt/soft/dingdingsql "${line}"
    fi

  done < $file

}

main(){
   if [ -e $file ];then
      filetimestamp=`stat $file |grep Modify|awk '{print $2,$3}'|xargs -i date -d {} +%s`
      
      tmptime=$(($filetimestamp+60))
      if [ $tmptime -ge $currenttimestamp ];then
         findalllog
   
      fi
   
   
   
   fi
}

main

