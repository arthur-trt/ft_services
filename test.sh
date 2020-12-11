api_ip=$(kubectl config view -o jsonpath='{"Cluster name\tServer\n"}{range .clusters[*]}{.name}{"\t"}{.cluster.server}{"\n"}{end}' | awk '/https/ {print $2}')

echo ${api_ip}

sed -i "s|url =.*|url = \"${api_ip}\"|" srcs/telegraf/srcs/telegraf.conf
