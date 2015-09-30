#!/bin/sh 
if [ $# -lt 1 ];then
   echo You must specify the directory of processed GPS data
   exit 1
fi

dir=$1
num=$(wc vel.dat | gawk '{print $1}')
echo $num

for ((ll=1;ll<=$num;ll++));do
    staname=$(sed -n ''$ll'p' vel.dat | gawk '{print $1}')
    echo $staname
    echo $dir/$staname

    for file in $(ls $dir/$staname/*.gd);do
    echo $file
    cat $file >> sites.gd
    break
    done

done
    


