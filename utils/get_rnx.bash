#!/bin/sh 
##################### Created by Q.Yang 03/06/2012 ###########################################
############ will download rinex/hantanaka data from unavco/CDDIS/SOPAC/IGN ftp archive for given data #######
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
echo "ftp -i -n garner.ucsd.edu<< EOF" > get_sopac_${net}_$year
echo "user anonymous qianyang@mail.usf.edu" >>get_sopac_${net}_$year
echo binary >>get_sopac_${net}_$year
echo "cd /pub/rinex/$year/$doy" >>get_sopac_${net}_$year
   for SITE in $(grep -h qian /data2/yang/gpsProcessing/${net}/sta_info/sta_id | awk '{print $1}');do
       site=$(echo $SITE |tr '[A-Z]' '[a-z]')
   echo "get $site${doy}0.${yr}d.Z" >>get_sopac_${net}_$year
done
echo quit >>get_sopac_${net}_$year
echo EOF >>get_sopac_${net}_$year

/bin/sh get_sopac_${net}_$year

#echo "Retrieving $net sites from UNAVCO archive"
echo "ftp -i -n data-out.unavco.org<< EOF" >get_unavco_${net}_$year
echo "user anonymous qianyang@mail.usf.edu" >>get_unavco_${net}_$year
echo binary >>get_unavco_${net}_$year
echo "cd /pub/rinex/obs/$year/$doy" >>get_unavco_${net}_$year
    for SITE in $(grep -h qian /data2/yang/gpsProcessing/${net}/sta_info/sta_id | awk '{print $1}');do
        site=$(echo $SITE |tr '[A-Z]' '[a-z]')
        if [ ! -s $site${doy}0.${yr}d.Z ];then
           echo "get $site${doy}0.${yr}d.Z" >>get_unavco_${net}_$year
fi
done
echo quit >>get_unavco_${net}_$year
echo EOF >>get_unavco_${net}_$year
/bin/sh get_unavco_${net}_$year
rm get_unavco_${net}_$year get_sopac_${net}_$year >/dev/null 2>&1







