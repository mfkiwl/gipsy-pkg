#!/bin/sh 
##################### Created by Q.Yang 03/06/2012 ###########################################
############ will download CROS rinex data from NGS  #########################################
############ you must specify the network name the same as in /*/*/sta_info/sta_id file ######

if [ $# -lt 3 ];then
echo You must specify the DOY, YEAR and GPS net
exit 1
fi

doy=$1
year=$2
net=$3
yr=`echo $year |cut -c3-4`

#echo "Retrieving $net sites from SOPAC"
echo "ftp -i -n www.ngs.noaa.gov<< EOF" > get_cors_${net}_$year
echo "user anonymous qianyang@mail.usf.edu" >>get_cors_${net}_$year
echo binary >>get_cors_${net}_$year
for SITE in $(grep -h qian /home/yang/COM_stainfo/sta_id_${net} | awk '{print $1}');do
       site=$(echo $SITE |tr '[A-Z]' '[a-z]')
       echo "cd /cors/rinex/$year/$doy/$site" >>get_cors_${net}_$year
   #for SITE in $(grep -h qian /data2/yang/gpsProcessing/${net}/sta_info/sta_id | awk '{print $1}');do
   #    site=$(echo $SITE |tr '[A-Z]' '[a-z]')
   echo "get $site${doy}0.${yr}d.Z" >>get_cors_${net}_$year
done
echo quit >>get_cors_${net}_$year
echo EOF >>get_cors_${net}_$year

/bin/sh get_cors_${net}_$year

rm get_cors_${net}_$year >/dev/null 2>&1







