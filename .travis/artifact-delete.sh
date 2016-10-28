#!/bin/sh

ftp_ip=ftp.wuetherich.com
ftp_port=21

for i in `curl -s -l ftp://"$user":"$password"@"$ftp_ip/" | grep .jar`; do
{
       echo "deleting $i";
       curl ftp://${ftp_ip}:${ftp_port}/${i} -u "$user:$password" -O --quote "DELE ${i}"
};
done;

for i in `curl -s -l ftp://"$user":"$password"@"$ftp_ip/plugins/" | grep .jar`; do
{
       echo "deleting plugins/$i";
       curl ftp://${ftp_ip}:${ftp_port}/plugins/${i} -u "$user:$password" -O --quote "DELE plugins/${i}"
};
done;

for i in `curl -s -l ftp://"$user":"$password"@"$ftp_ip/features/" | grep .jar`; do
{
       echo "deleting features/$i";
       curl ftp://${ftp_ip}:${ftp_port}/features/${i} -u "$user:$password" -O --quote "DELE features/${i}"
};
done;