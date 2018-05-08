#!/bin/bash
set -e

cd /usr/src/app/conf
rm -rf /usr/src/app/conf/*
rm -f /usr/src/app/conf/.env
STR=$'#!/bin/bash\n'
echo "$STR" > .env
#source /usr/src/conf/.env
git config --global http.sslVerify false

git clone $GLOBALCONF
cd $GLOBALCONFFOLDER
git checkout conjur
cd ..
#source $GLOBALCONFFILE

git clone $SYSTEMCONF
cd $SYSTEMCONFFOLDER
git checkout conjur
cd ..
#source $SYSTEMCONFFILE

cat $GLOBALCONFFILE $SYSTEMCONFFILE > .env

nginx -g "daemon off;"