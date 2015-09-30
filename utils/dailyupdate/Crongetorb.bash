############## download JPL orbits ################################
############## Qian Yang, Aug 21 2014 #############################
#!/bin/bash 
pwd=`pwd`

### get today's year, month, day and day of year ########
today=`date | awk '{yr=$6;dd=$3;if ($2 == "Jan") {mm=1} else if ($2 == "Feb") {mm=2} else if ($2 == "Mar") {mm=3} else if ($2 == "Apr") {mm=4} else if ($2 == "May") {mm=5} else if ($2 == "Jun") {mm=6} else if ($2 == "Jul") {mm=7} else if ($2 == "Aug") {mm=8} else if ($2 =="Sep") {mm=9} else if ($2=="Oct") {mm=10} else if ($2 == "Nov") {mm=11} else {mm=12} print yr,mm,dd}'`
#td_Yr=`echo $today | cl c1 | sed 's/\ //g'`
td_Yr=$(echo $today | awk '{print $1}')
td_mm=`echo $today | awk '{printf "%02i",$2}'`
td_dd=`echo $today | awk '{printf "%02i",$3}'`
td_doy=$(bash /home/yang/bin/dailyupdate/cal2doy.bash $td_Yr $td_mm $td_dd)

lastYr=`ls -d /GPS/JPLorbits/Final/2??? | sort | tail -1 | cut -c22-25`
lastDate=`ls /GPS/JPLorbits/Final/$lastYr/${lastYr}*|tail -1|awk '{print(substr($1,27,10))}'| sed 's/\-/ /g'`
#lastDoy=`cal2doy $lastDate | cl c5`
lastDoy=$(bash /home/yang/bin/dailyupdate/cal2doy.bash $lastDate)

if [ "$lastYr" == "2016" ] || [ "$lastYr" == "2020" ];then
tot_doy=366   #total number of days in leap year
else
tot_doy=365   #total number of days in normal year
fi

#echo $lastYr $td_Yr $lastDoy $tot_doy
if [ "$lastYr" -lt "$td_Yr" ] && [ "$lastDoy" -lt "$tot_doy" ]; then
echo $lastYr download has not finish, continue download $lastYr
DIR=/GPS/JPLorbits/Final/$lastYr
year=$lastYr
stdoy=$lastDoy
etdoy=$tot_doy
cd $DIR
   for i in `seq $stdoy $etdoy`; do
   date=`bash /home/yang/bin/dailyupdate/doy2cal.bash $year $i | awk '{printf("%4s-%02i-%02i",$1,$2,$3)}'`
   f="ftp://sideshow.jpl.nasa.gov/pub/JPL_GPS_Products/Final/$year/$date"
   wget "$f*" >& /dev/null
   done
   rm *.1
   cd $pwd
fi

if [ "$lastDoy" -eq "$tot_doy" ] && [ "$lastYr" -lt "$td_Yr" ]; then
   echo $lastYr is finished, start to download $td_Yr
   DIR=/GPS/JPLorbits/Final/$td_Yr
   mkdir -p $DIR
   year=$td_Yr
   stdoy=001
   etdoy=$td_doy
   cd $DIR
     for i in `seq $stdoy $etdoy`; do
     date=`bash /home/yang/bin/dailyupdate/doy2cal.bash $year $i | awk '{printf("%4s-%02i-%02i",$1,$2,$3)}'`
     f="ftp://sideshow.jpl.nasa.gov/pub/JPL_GPS_Products/Final/$year/$date"
     wget "$f*" >& /dev/null
     done
   rm *.1
   cd  $pwd
   if [ ! "$(ls -A $DIR)" ]; then
      echo $DIR is empty, so delete it
      rm -r $DIR
   fi
fi

if [ "$lastDoy" -lt "$tot_doy" ] && [ "$lastYr" -eq "$td_Yr" ]; then
   echo continue download $td_Yr
   DIR=/GPS/JPLorbits/Final/$td_Yr
   year=$td_Yr
   stDate=`ls ${DIR}/${year}*|tail -1|awk '{print(substr($1,27,10))}'| sed 's/\-/ /g'`
   stdoy=`bash /home/yang/bin/dailyupdate/cal2doy.bash $stDate`
   etdoy=$td_doy
   echo $stdoy $etdoy
   cd $DIR
   for i in `seq $stdoy $etdoy`; do
       date=`bash /home/yang/bin/dailyupdate/doy2cal.bash $year $i | awk '{printf("%4s-%02i-%02i",$1,$2,$3)}'`
       echo $date
       f="ftp://sideshow.jpl.nasa.gov/pub/JPL_GPS_Products/Final/$year/$date"
       wget "$f*" >& /dev/null
   done
   rm *.1
   cd  $pwd
fi

