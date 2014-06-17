#!/bin/sh

# merge dev into master
currentVersion=`cat version.sbt | cut -d\" -f2`
releaseVersion=`echo $currentVersion | awk -F. '{ $NF+=1; OFS="."; print $0 }'`

git merge origin/dev

# bump the master version
echo "version in ThisBuild := \"$releaseVersion\"" > version.sbt
git commit -am "Release version $releaseVersion"

sbt test

# push to origin
git push origin master

# tag the release
git tag -a "v$releaseVersion" -m "relase version $releaseVersion"
git push origin --tags
