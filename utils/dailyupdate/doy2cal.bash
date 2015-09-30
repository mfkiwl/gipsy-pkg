#!/bin/sh
#convert year doy to year month day 

if [ $# -lt 2 ]; then
   echo You must specify year doy
   exit 1
fi

year=$1
doy=$2

if [ $year -eq 2016 ] || [ $year -eq 2012 ];
then
mon=`echo $doy | awk '{if ($1 >= 1 && $1 <=31) {mm=1} else if ($1 >= 32 && $1 <=60) {mm=2} else if ($1 >= 61 && $1 <=91) {mm=3} else if ($1 >= 92 && $1 <=121) {mm=4} else if ($1 >= 122 && $1 <=152) {mm=5} else if ($1 >= 153 && $1 <=182) {mm=6} else if ($1 >= 183 && $1 <=213) {mm=7} else if ($1 >= 214 && $1 <=244) {mm=8} else if ($1 >= 245 && $1 <=274) {mm=9} else if ($1 >= 275 && $1 <=305) {mm=10} else if ($1 >= 306 && $1 <=335) {mm=11} else if ($1 >= 336 && $1 <=366) {mm=12} print mm}'`
dd=`echo $mon | awk '{if ($1 == "1") {d=0} else if ($1 == "2") {d=31} else if ($1 == "3") {d=60} else if ($1 == "4") {d=91} else if ($1 == "5") {d=121} else if ($1 == "6") {d=152} else if ($1 == "7") {d=182} else if($1 == "8") {d=213} else if ($1 == "9") {d=244} else if ($1 == "10") {d=274} else if ($1 == "11") {d=305} else if ($1 == "12") {d=335} print d}'`
day=$(expr $doy - $dd)
echo $year $mon $day
else
mon=`echo $doy | awk '{if ($1 >= 1 && $1 <=31) {mm=1} else if ($1 >= 32 && $1 <=59) {mm=2} else if ($1 >= 60 && $1 <=90) {mm=3} else if ($1 >= 91 && $1 <=120) {mm=4} else if ($1 >= 121 && $1 <=151) {mm=5} else if ($1 >= 152 && $1 <=181) {mm=6} else if ($1 >= 182 && $1 <=212) {mm=7} else if ($1 >= 213 && $1 <=243) {mm=8} else if ($1 >= 244 && $1 <=273) {mm=9} else if ($1 >= 274 && $1 <=304) {mm=10} else if ($1 >= 305 && $1 <=334) {mm=11} else if ($1 >= 335 && $1 <=365) {mm=12} print mm}'`
dd=`echo $mon | awk '{if ($1 == "1") {d=0} else if ($1 == "2") {d=31} else if ($1 == "3") {d=59} else if ($1 == "4") {d=90} else if ($1 == "5") {d=120} else if ($1 == "6") {d=151} else if ($1 == "7") {d=181} else if($1 == "8") {d=212} else if ($1 == "9") {d=243} else if ($1 == "10") {d=273} else if ($1 == "11") {d=304} else if ($1 == "12") {d=334} print d}'`
day=$(expr $doy - $dd)
echo $year $mon $day
fi
