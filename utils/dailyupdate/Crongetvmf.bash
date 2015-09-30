############# download VMF files ####################
############# Qian Yang, Aug 25, 2014 ###############
#!/bin/sh

pwd=`pwd`

### get today's year, month, day and day of year ########
today=`date | awk '{yr=$6;dd=$3;if ($2 == "Jan") {mm=1} else if ($2 == "Feb") {mm=2} else if ($2 == "Mar") {mm=3} else if ($2 == "Apr") {mm=4} else if ($2 == "May") {mm=5} else if ($2 == "Jun") {mm=6} else if ($2 == "Jul") {mm=7} else if ($2 == "Aug") {mm=8} else if ($2 =="Sep") {mm=9} else if ($2=="Oct") {mm=10} else if ($2 == "Nov") {mm=11} else {mm=12} print yr,mm,dd}'`
#td_Yr=`echo $today | cl c1 | sed 's/\ //g'`
td_Yr=$(echo $today | awk '{print $1}')
td_mm=`echo $today | awk '{printf "%02i",$2}'`
td_dd=`echo $today | awk '{printf "%02i",$3}'`
td_doy=$(bash /home/yang/bin/dailyupdate/cal2doy.bash $td_Yr $td_mm $td_dd)

### get last's year and day of year ###############
lastYr=`ls -d /GPS/VMF1/2??? | sort | tail -1 | cut -c11-14`
lastDoy=`ls /GPS/VMF1/$lastYr/ah/ah?????.h18 |tail -1 | cut -c23-25`

if [ "$lastYr" == "2016" ] || [ "$lastYr" == "2020" ];then
tot_doy=366   #total number of days in leap year
else
tot_doy=365   #total number of days in normal year
fi

echo $lastYr $lastDoy $td_Yr $td_doy

if [ "$lastYr" -lt "$td_Yr" ] && [ "$lastDoy" -lt "$tot_doy" ]; then
echo $lastYr download has not finish, continue download $lastYr
DIR=/GPS/VMF1/$lastYr
year=$lastYr
year2d=$(echo $year | cut -c3-4)
stdoy=$lastDoy
etdoy=$tot_doy
cd $DIR
for i in `seq $stdoy $etdoy`; do
    d=$(echo $i | awk '{printf("%03d",$1)}')
    for a in ah aw zh zw; do
    cd $a
        for b in 00 06 12 18; do
            wget http://ggosatm.hg.tuwien.ac.at/DELAY/GRID/STD/$year/${a}${year2d}${d}.h$b # >& /dev/null 
        done
        rm *.1
    cd ..
    done
done
cd ..
fi

if [ "$lastDoy" -eq "$tot_doy" ] && [ "$lastYr" -lt "$td_Yr" ]; then
   echo $lastYr is finished, start to download $td_Yr
   DIR=/GPS/VMF1/$td_Yr
   mkdir -p $DIR
   year=$td_Yr
   year2d=$(echo $year | cut -c3-4)
   stdoy=001
   etdoy=$td_doy
   cd $DIR
   for i in `seq $stdoy $etdoy`; do
    d=$(echo $i | awk '{printf("%03d",$1)}')
    for a in ah aw zh zw; do
    cd $a
        for b in 00 06 12 18; do
            wget http://ggosatm.hg.tuwien.ac.at/DELAY/GRID/STD/$year/${a}${year2d}${d}.h$b # >& /dev/null 
        done
        rm *.1
    cd ..
    done
   done
   cd ..
   if [ ! "$(ls -A $DIR/ah)" ]; then
   echo $DIR is empty, so delete it
   rm -r $DIR
   fi
fi

if [ "$lastDoy" -lt "$tot_doy" ] && [ "$lastYr" -eq "$td_Yr" ]; then
   echo continue download $td_Yr
   DIR=/GPS/VMF1/$td_Yr
   year=$td_Yr
   year2d=$(echo $year | cut -c3-4)
   stdoy=`ls /GPS/VMF1/$lastYr/ah/ah${year2d}???.h18 |tail -1 | cut -c23-25`
   etdoy=$td_doy
   cd $DIR
   for i in `seq $stdoy $etdoy`; do
       d=$(echo $i | awk '{printf("%03d",$1)}')
       for a in ah aw zh zw; do
           cd $a
           for b in 00 06 12 18; do
               f="http://ggosatm.hg.tuwien.ac.at/DELAY/GRID/STD/$year/${a}${year2d}${d}.h$b"
               wget http://ggosatm.hg.tuwien.ac.at/DELAY/GRID/STD/$year/${a}${year2d}${d}.h$b # >& /dev/null 
           done
           rm *.1
       cd ..
       done
   done
   cd ..
fi
