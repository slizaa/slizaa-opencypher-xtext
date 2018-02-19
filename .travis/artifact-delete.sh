#!/bin/sh

#
ftp_ip=ftp.wuetherich.com
ftp_port=21
target_dir=slizaa-opencypher-xtext

#
for i in `curl --ssl -k -s -l ftp://"$user":"$password"@"$ftp_ip/$target_dir" | grep .jar`; do
{
       echo "deleting $i";
       curl --ssl -k ftp://${ftp_ip}:${ftp_port}/$target_dir/${i} -u "$user:$password" -O --quote "DELE ${i}"
};
done;

for i in `curl --ssl -k -s -l ftp://"$user":"$password"@"$ftp_ip/$target_dir/plugins/" | grep .jar`; do
{
       echo "deleting plugins/$i";
       curl --ssl -k ftp://${ftp_ip}:${ftp_port}/$target_dir/plugins/${i} -u "$user:$password" -O --quote "DELE $target_dir/plugins/${i}"
};
done;

for i in `curl --ssl -k -s -l ftp://"$user":"$password"@"$ftp_ip/$target_dir/features/" | grep .jar`; do
{
       echo "deleting features/$i";
       curl --ssl -k ftp://${ftp_ip}:${ftp_port}/$target_dir/features/${i} -u "$user:$password" -O --quote "DELE $target_dir/features/${i}"
};
done;