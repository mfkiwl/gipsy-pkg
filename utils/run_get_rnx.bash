#!/bin/sh
################### Created by Q.Yang 03/14/2012 ###################
####### will call get_rnx.bash to download GPS rinex data ##########
####### download one day in one year for all sites in sta_id every time call get_rnx.bash ######
################################################################################################ 
if [ $# -lt 3 ];then
echo You must specify the start Year and end Year and GPS Net
exit 1
fi

STY=$1
ETY=$2
NET=$3
for ((year=$1;year<=$2;year++))
do
ye=$(echo $year | awk '{printf "%04d",$year}')
for ((day=128;day<=206;day++))
do
da=$(echo $day | awk '{printf "%03d",$day}')
bash ~/utils/get_rnx_NGS.bash $da $ye $NET
done
done

for SITE in $(grep -h qian /home/yang/COM_stainfo/sta_id_"$NET" | awk '{print $1}');do
    site=$(echo $SITE |tr '[A-Z]' '[a-z]')
#    mkdir $SITE
      for ((yea=$1;yea<=$2;yea++))
        do
        cd $SITE
#        mkdir $yea
        cd ..
        y=`echo $yea |cut -c3-4`
        mv $site???0.${y}d.Z $SITE/$yea/
        if [ ! "$(ls -A $SITE/$yea)" ]; then 
          rm -r $SITE/$yea
          fi 
   done
        if [ ! "$(ls -A $SITE)" ];then
        rm -r $SITE
        fi
done

