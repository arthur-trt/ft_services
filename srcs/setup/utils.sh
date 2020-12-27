#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    utils.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/14 11:35:23 by atrouill          #+#    #+#              #
#    Updated: 2020/12/14 11:35:34 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

function	install_mkcert()
{
	echo -e "${C_CYAN}Configure mkCert${C_RESET}"
	echo "⌛ Install mkCert"
	if [[ ! -f "/usr/local/bin/mkcert" ]]; then
		sudo su -c "apt install libnss3-tools" &>> logs/mkcert.log
		sudo su -c "wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert" &>> logs/mkcert.log
		sudo su -c "chmod +x /usr/local/bin/mkcert" &>> logs/mkcert.log
		echo -e "${EREASE}✅ Configuring mkCert is done !"
	else
		echo -e "${EREASE}✅ mkCert is already present !"
	fi
	echo "⌛ Install mkCert"
	mkcert -install &>> logs/mkcert.log
	echo -e "${EREASE}✅ mkCert is installed !"
}

function	configure_mkcert()
{
	for i in {150..160}
	do
		ips="${ips} ${baseip}.${i} "
	done
	echo "⌛ Generate certificate"
	mkcert -key-file server.key -cert-file server.crt ${ips} &>> logs/mkcert.log
	cp server.key srcs/nginx/srcs/
	cp server.crt srcs/nginx/srcs/
	mv server.key srcs/wordpress/srcs/
	mv server.crt srcs/wordpress/srcs/
	echo -e "${EREASE}✅ Certificates is generated !"
}

function	clean()
{
	rm -rf logs/*
	rm -f metalLB.yaml
	rm -f srcs/nginx/srcs/server.*
	rm -f srcs/wordpress/srcs/server.*
}

