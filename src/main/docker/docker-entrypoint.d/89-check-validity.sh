#!/bin/bash

currentDate=`date +%s`
if [ -z "${BUILD_DATE}" ]
then
    1>&2 echo "************"
    1>&2 echo "This is an old image: BUILD_DATE is not set"
    1>&2 echo "************"
else
    timeelapsed=`expr ${currentDate} - ${BUILD_DATE}`
    if [ $timeelapsed -ge 2592000 ] # 30 days
    then
	1>&2 echo "************"
	1>&2 echo "This is an old image: BUILD_DATE=$(date -d @$BUILD_DATE +"%Y-%m-%d %H:%M:%S") and currentDate=$(date -d @$currentDate +"%Y-%m-%d %H:%M:%S")"
	1>&2 echo "************"
    fi
fi


