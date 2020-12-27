#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    show_infos.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/09 15:45:09 by atrouill          #+#    #+#              #
#    Updated: 2020/12/09 15:45:10 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

function	nginx_infos()
{
	ssh_pass=$(kubectl get secret pass-secret -o jsonpath="{.data.ssh_pass}" | base64 --decode)
	echo -e "Adress HTTP :\thttp://${lb_ip}/"
	echo -e "Adress HTTPS :\thttps://${lb_ip}/"
	echo -e "Username :\tuser42"
	echo -e "Password :\t${ssh_pass}"

}

function	wordpress_infos()
{
	wordpress_pass=$(kubectl get secret pass-secret -o jsonpath="{.data.wordpress_admin_pass}" | base64 --decode)
	echo -e "Address HTTPS :\thttps://${lb_ip}/wordpress"
	echo -e "Address IP :\thttps://${lb_ip}:5050"
	echo -e "Username :\tadmin"
	echo -e "Password :\t${wordpress_pass}"
}

function	phpmyadmin_infos()
{
	mysql_pass=$(kubectl get secret pass-secret -o jsonpath="{.data.mysql_admin_pass}" | base64 --decode)
	echo -e "Address HTTPS :\thttps://${lb_ip}/phpmyadmin"
	echo -e "Address IP :\thttp://${lb_ip}:5000"
	echo -e "Username :\tadmin"
	echo -e "Password :\t${mysql_pass}"
}

function grafana_infos()
{
	echo -e "Address IP :\thttp://${lb_ip}:3000"
	echo -e "Username :\tadmin"
	echo -e "Password :\tadmin"
}

function	ftps_info()
{
	ftps_pass=$(kubectl get secret pass-secret -o jsonpath="{.data.ftps_pass}" | base64 --decode)
	echo -e "Address IP :\tftps://${lb_ip}:21"
	echo -e "Username :\tuser42"
	echo -e "Password :\t${ftps_pass}"
}

function	show_infos()
{
	echo -e "\n\n${C_CYAN}Informations :${C_RESET}"
	echo -e "${C_MAG}NGINX :${C_RESET}"
	nginx_infos
	echo -e "\n${C_MAG}WordPress :${C_RESET}"
	wordpress_infos
	echo -e "\n${C_MAG}PHPMyAdmin :${C_RESET}"
	phpmyadmin_infos
	echo -e "\n${C_MAG}Grafana :${C_RESET}"
	grafana_infos
	echo -e "\n${C_MAG}FTPS :${C_RESET}"
	ftps_info
}
