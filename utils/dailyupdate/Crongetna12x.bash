######################## download NA12.x files ####################################
######################## Qian Yang, Aug 25, 2014 ##################################
#!/bin/sh

pwd=`pwd`

lastYr=`ls -d /GPS/JPLorbits/Final/2??? | sort | tail -1 | cut -c22-25`
lastDate=`ls /GPS/JPLorbits/Final/$lastYr/${lastYr}*|tail -1|awk '{print(substr($1,27,10))}'| sed 's/\-/ /g'` 
lastDoy=`bash /home/yang/bin/dailyupdate/cal2doy.bash $lastDate `

lastDateNA=`ls /GPS/JPLorbits/Final/$lastYr/*.NA12.x.gz | tail -1|awk '{print(substr($1,27,10))}'| sed 's/\-/ /g'`
if [ "$lastDateNA" == "" ];then
lastDoyNA=001
else
lastDoyNA=`bash /home/yang/bin/dailyupdate/cal2doy.bash $lastDateNA`
fi

cd /GPS/JPLorbits/Final/$lastYr
if [ $lastDoyNA -lt $lastDoy ]; then
   for i in `seq $lastDoyNA $lastDoy`; do
         date=`bash /home/yang/bin/dailyupdate/doy2cal.bash $lastYr $i|awk '{printf("%4s-%02i-%02i",$1,$2,$3)}'`
	 yr=$(echo $date | cut -c3-4)
	 mo=$(echo $date | cut -c6-7)
	 dy=$(echo $date | cut -c9-10)
	 if [ "$mo" == "01" ]; then
	    MO="JAN"
	 elif [ "$mo" == "02" ];then
	    MO="FEB"
	 elif [ "$mo" == "03" ];then
            MO="MAR"
         elif [ "$mo" == "04" ];then
            MO="APR"
         elif [ "$mo" == "05" ];then
            MO="MAY"
         elif [ "$mo" == "06" ];then
            MO="JUN"
         elif [ "$mo" == "07" ];then
            MO="JUL"
         elif [ "$mo" == "08" ];then
           MO="AUG"
         elif [ "$mo" == "09" ];then
           MO="SEP"
         elif [ "$mo" == "10" ];then
           MO="OCT"
         elif [ "$mo" == "11" ];then
           MO="NOV"
         elif [ "$mo" == "12" ];then
           MO="DEC"
         fi
	 file="$yr""$MO""$dy".NA12.x
         newname="$lastYr"-"$mo"-"$dy".NA12.x
	 f="ftp://gneiss.nbmg.unr.edu/x-files/$file"
	 wget "$f*" >& /dev/null
         mv $file $newname
   done
   gzip -f *NA12.x 
fi

cd $pwd
