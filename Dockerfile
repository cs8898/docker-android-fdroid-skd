FROM runmymind/docker-android-sdk

ENV PATH="/opt/android-sdk-linux/build-tools/28.0.3:${PATH}"

RUN apt-get update -yqq && \
    apt-get install -y libnss-wrapper && \
    apt-get clean

# copy some command aliases that need to be early on the path
COPY tools/* /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/run_as_user && \
    chmod a+x /usr/local/sbin/ssh && \
    chmod a+x /usr/local/sbin/rsync

RUN apt-get update -yqq && \
    apt-get install -y \
    fdroidserver && \
    apt-get clean

RUN cd /usr/share/doc/fdroidserver/examples && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/config.py && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/fdroid-icon.png && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/makebuildserver.config.py && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/opensc-fdroid.cfg && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/public-read-only-s3-bucket-policy.json && \
    wget https://raw.githubusercontent.com/f-droid/fdroidserver/master/examples/template.yml

RUN cd $ANDROID_SDK_HOME && \
    chmod -R o+rw .
