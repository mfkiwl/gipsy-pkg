#!/bin/bash
#-----------------------------------------------------------------------------------------
# Q.Yang 03/01/2011
# Modified by Q.Yang 09/20/2011
# This script is used to download summery log file of GPS sites for unvaco or ucsd or cddi
# You must specify the name of site the same as in ~/sta_id
#------------------------------------------------------------------------------------------

echo "Retrieving log file from UNAVCO"
echo "ftp -i -n data-out.unavco.org << EOF" >get_unavco_logfile
echo "user anonymous qyang@rsmas.miami.edu" >>get_unavco_logfile
echo binary >>get_unavco_logfile
#echo epsv4 >>get_unavco_logfile
echo "cd /pub/logs/" >>get_unavco_logfile
for SITE in $(grep -h qian ~/COM_stainfo/sta_id_greenland |gawk '{print $1}');do
    site=$(echo $SITE |tr '[A-Z]' '[a-z]')
	echo $site
	echo "get "$site"log.txt">>get_unavco_logfile
done
echo quit >>get_unavco_logfile
echo EOF >>get_unavco_logfile
 /bin/sh ./get_unavco_logfile


echo "Retrieving log file from UCSD"
echo "ftp -i -n garner.ucsd.edu << EOF" >get_ucsd_logfile
echo "user anonymous qyang@rsmas.miami.edu" >>get_ucsd_logfile
echo binary >>get_ucsd_logfile
#echo epsv4 >>get_ucsd_logfile
echo "cd /pub/docs/site_logs/" >>get_ucsd_logfile
for SITE in $(grep -h qian ~/COM_stainfo/sta_id_greenland |gawk '{print $1}');do
    site=$(echo $SITE |tr '[A-Z]' '[a-z]')
	echo $site
	echo "get "$site".log.txt">>get_ucsd_logfile
done
echo quit >>get_ucsd_logfile
echo EOF >>get_ucsd_logfile
 /bin/sh ./get_ucsd_logfile

rm get_ucsd_logfile get_unavco_logfile >/dev/null 2>&1
mv *log.txt ~/logfile/greenland/
