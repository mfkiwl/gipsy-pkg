#!/bin/bash
#-----------------------------------------------------------------------------------------
# Q.Yang 03/01/2011
# Modified by Q.Yang 09/20/2011
# This script is used to download summery log file of GPS sites for NGS
# You must specify the name of site the same as in ~/sta_id
#------------------------------------------------------------------------------------------

echo "Retrieving log file from NGS"
echo "ftp -i -n www.ngs.noaa.gov << EOF" >get_ngs_logfile
echo "user anonymous qyang@rsmas.miami.edu" >>get_ngs_logfile
echo binary >>get_ngs_logfile
echo "cd /cors/station_log/" >>get_ngs_logfile
for SITE in $(grep -h qian ~/COM_stainfo/sta_id_cors |gawk '{print $1}');do
    site=$(echo $SITE |tr '[A-Z]' '[a-z]')
	echo $site
	echo "get "$site".log.txt">>get_ngs_logfile
done
echo quit >>get_ngs_logfile
echo EOF >>get_ngs_logfile
 /bin/sh ./get_ngs_logfile



rm get_ngs_logfile >/dev/null 2>&1
mv *log.txt ~/logfile/cors/
