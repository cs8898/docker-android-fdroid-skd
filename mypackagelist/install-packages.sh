#!/bin/bash
while read p; do 
    /opt/tools/android-accept-licenses.sh "sdkmanager ${SDKMNGR_OPTS} ${p}"
done < /opt/mypackagelist/package-list.txt