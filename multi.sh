#!/bin/sh
# USAGE multi.sh 10 test.sh bob0
NB=$1
SCRIPT=$2
ROOM=$3

for i in `seq 1 $NB`
do
sh $SCRIPT $ROOM&
echo $i
sleep 2
done
