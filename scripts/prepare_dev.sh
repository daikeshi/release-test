#!/bin/sh

git merge origin/master

currentVersion=`cat version.sbt | cut -d\" -f2`

# bump next dev version
nextDevVersion=`echo $currentVersion | awk -F. '{ $NF+=1; OFS="."; print $0 }'`
nextDevVersion="$nextDevVersion-SNAPSHOT"
echo "version in ThisBuild := \"$nextDevVersion\"" > version.sbt
git commit -am "Prepare next dev version $nextDevVersion"

sbt test

git push origin dev
