#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    secret_gen.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 14:15:08 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 14:18:35 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function obtain_loadbalancer_ip() {
	lb_ip=`kubectl get svc | awk '/LoadBalancer/ {if (!seen[$4]++){print $4}}'`

	while ! valid_ip ${lb_ip}; do
		echo "⌛ Wait for services to be ready."
		lb_ip=`kubectl get svc | awk '/LoadBalancer/ {if (!seen[$4]++){print $4}}'`
		echo -e "${EREASE}${EREASE}"
	done
	echo "✅ Services ready !"
}

function build_secret() {
	obtain_loadbalancer_ip
	sed -i "s|loadbalancer_ip:.*|loadbalancer_ip: \"$(echo ${lb_ip} | base64)\"|" srcs/secret.yaml
	sed -i "s|ftps_pass:.*|ftps_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|ssh_pass:.*|ssh_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|influxdb_admin_pass:.*|influxdb_admin_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|influxdb_telegraf_user_pass:.*|influxdb_telegraf_user_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|influxdb_grafana_user_pass:.*|influxdb_grafana_user_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|mysql_admin_pass:.*|mysql_admin_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|mysql_wordpress_user_pass:.*|mysql_wordpress_user_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|ssh_pass:.*|ssh_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
	sed -i "s|wordpress_admin_pass:.*|wordpress_admin_pass: \"$(openssl rand -base64 32 | tr -dc _A-Z-a-z-0-9 | base64 )\"|" srcs/secret.yaml
}
