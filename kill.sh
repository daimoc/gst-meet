#!/bin/sh

sudo docker container kill `sudo docker ps |grep "gstmeet"|awk '{print $1}'`