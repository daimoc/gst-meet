#!/bin/bash

for value in {0..10}
do
echo $value
sh test.sh &
sleep 1
done
