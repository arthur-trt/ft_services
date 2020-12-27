# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    launch.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/01 15:53:11 by atrouill          #+#    #+#              #
#    Updated: 2020/12/26 18:02:20 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

openrc
touch /run/openrc/softlevel

adduser -D "user42" && echo "user42:${SSH_PASSWORD}" | chpasswd
chown -R user42:user42 /home/user42

if [[ -f "server.crt" && -f "server.key" ]]; then
	mv server.crt /etc/ssl/certs/server.crt
	mv server.key /etc/ssl/private/server.key
fi

awk -v VAR="$(echo ${LB_IP} | tr -d '\n')" '{gsub(/LB_IP/,VAR)}1' /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

service nginx start
service sshd start

tail -F /var/log/nginx/access.log
