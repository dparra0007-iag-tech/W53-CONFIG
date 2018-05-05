#!/bin/bash
CONFIGMAPNAME=$(echo $CONFIG_NAME | tr '[:upper:]' '[:lower:]')
PROJECTNAME=$(echo $PROJECT_NAME | tr '[:upper:]' '[:lower:]')

echo "Getting config.properties file ..."
mkdir -p /usr/src/app
cd /usr/src/app
git clone https://github.com/dparra0007/$CONFIG_NAME.git
cd $CONFIG_NAME
git checkout openshift

echo "Login to openshift ..."
oc login $OC_URL --token $OC_TOKEN --insecure-skip-tls-verify
#oc login $OC_URL --username=$USER --password=$PASS --insecure-skip-tls-verify=true
oc project $PROJECTNAME | oc new-project $PROJECTNAME

echo "Building configmap command ..."
cmn=${CONFIGMAPNAME//+([-])/.}
command="oc create configmap $cmn "
while read p; do
  command="$command --from-literal=$p "
done <config.properties

echo "Executing command ..."
echo $command
eval $command
