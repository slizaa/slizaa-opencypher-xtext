#!/bin/sh

ftp_ip=ftp.wuetherich.com
target_dir=slizaa-opencypher-xtext

echo TRAVIS_BUILD_DIR: $TRAVIS_BUILD_DIR

PRODUCTS_DIR=$TRAVIS_BUILD_DIR/releng/org.slizaa.neo4j.opencypher.p2/target/repository
echo PRODUCTS_DIR: $PRODUCTS_DIR

filesToUpload=$(find $PRODUCTS_DIR -name "*.jar" -printf '%P\n')
echo filesToUpload: $filesToUpload

# change the working directory
cd $PRODUCTS_DIR

# upload all files
for localFile in $filesToUpload;
do
  echo "Uploading $localFile"
  curl --ssl -k -T $localFile ftp://"$user":"$password"@"$ftp_ip/$target_dir/$localFile"
done
