#!/bin/sh
#convert year month day to doy
#echo $$>j.num.$$

if [ $# -lt 3 ];then
   echo You must specify Year Month and Day
   exit 1
fi

year=$1
month=$2
day=$3

if [ $year -eq 2016 ] || [ $year -eq 2012 ];
then
   mday=`echo $month | awk '{if ($1 == "01") {mm=0} else if ($1 == "02") {mm=31} else if ($1 == "03") {mm=60} else if ($1 == "04") {mm=91} else if ($1 == "05") {mm=121} else if ($1 == "06") {mm=152} else if ($1 == "07") {mm=182} else if($1 == "08") {mm=213} else if ($1 == "09") {mm=244} else if ($1 == "10") {mm=274} else if ($1 == "11") {mm=305} else if ($1 == "12") {mm=335} print mm}'`
doy=$(expr $mday + $day)
else
   mday=`echo $month | awk '{if ($1 == "01") {mm=0} else if ($1 == "02") {mm=31} else if ($1 == "03") {mm=59} else if ($1 == "04") {mm=90} else if ($1 == "05") {mm=120} else if ($1 == "06") {mm=151} else if ($1 == "07") {mm=181} else if($1 == "08") {mm=212} else if ($1 == "09") {mm=243} else if ($1 == "10") {mm=273} else if ($1 == "11") {mm=304} else if ($1 == "12") {mm=334} print mm}'`
doy=$(expr $mday + $day)
fi

echo $doy
