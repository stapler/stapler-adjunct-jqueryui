#!/bin/bash -ex
tag=1.9.2
dst=$PWD/src/main/import/org/kohsuke/stapler/jqueryui
[ -d target ] && rm -rf target
mkdir target
wget -O target/jqueryui.zip http://jqueryui.com/resources/download/jquery-ui-1.9.2.custom.zip
pushd target
  unzip jqueryui.zip
  cd jquery-ui-$tag.custom

  [ -d $dst ] && rm -rf $dst
  mkdir -p $dst
  cp -R js css $dst
popd
pushd $dst
  rm $(ls js/jquery*.js | grep -v ui)
  for f in */jquery-ui* */*/jquery-ui*;
  do
    g=$(echo $f | sed -e "s/-$tag.custom//g")
    [ $f = $g ] || mv $f $g
  done
popd

#mvn -B release:update-versions -DdevelopmentVersion=$tag-1-SNAPSHOT
