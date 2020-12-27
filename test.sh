#!/bin/bash
baseip=192.168.49.

ips=""

for i in {150..160}
do
	ips="${ips} ${baseip}${i} "
done

echo ${ips}
