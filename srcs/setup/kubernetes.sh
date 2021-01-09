#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    kubernetes.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/09 15:19:50 by atrouill          #+#    #+#              #
#    Updated: 2020/12/09 15:19:51 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

function start_minikube()
{
	echo -e "${C_CYAN}Configuring Minikube${C_RESET}"
	echo "⌛ Staring Minikube"
	if minikube start --vm-driver=docker > logs/minikube.log; then
		eval $(minikube docker-env)				&>> logs/minikube.log
		echo -e "${EREASE}✅ Minikube started !"
	else
		echo -e "${EREASE}${EREASE}${C_RED}❌ Can't start minikube. Log saved.${C_RESET}"
		exit 1
	fi
	echo "⌛ Enable metrics-server"
	if minikube addons enable metrics-server &>> logs/minikube.log; then
		echo -e "${EREASE}✅ Metrics-server configured !"
	else
		echo -e "${EREASE}${EREASE}${C_RED}❌ Unable to activate the metrics-server. Log saved.${C_RESET}"
		exit 1
	fi
	echo "⌛ Enable dashboard"
	if minikube addons enable dashboard &>> logs/minikube.log; then
		echo -e "${EREASE}✅ Dashboard configured !"
	else
		echo -e "${EREASE}${EREASE}${C_RED}❌ Unable to activate the dashboard. Log saved.${C_RESET}"
		exit 1
	fi
}

function generate_ip()
{
	baseip=$(ip a | grep "br-" |  awk '/inet/ {print $2}')
	if [[ -z ${baseip} ]]; then
	    baseip=$(ip a | grep "docker" |  awk '/inet/ {print $2}')
	fi
	baseip=$(echo ${baseip} | cut -d"/" -f1 | cut -d"." -f1-3)
}


function configure_metalLB()
{
	rm -f srcs/metlaLB.yaml
	echo -e "${C_CYAN}Configure MetalLB${C_RESET}"
	echo "⌛ Download configuration"
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml					&>> logs/minikube.log
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml					&>> logs/minikube.log
	echo -e "${EREASE}✅ Configuration downloaded and applied!"
	echo "⌛ Create secret"
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"	&>> logs/minikube.log
	echo -e "${EREASE}✅ Setup secret done !"
	echo "⌛ Configure IPs for MetalLB"
	generate_ip
	sed -e "s|IP1|${baseip}.150|" srcs/metalLB-template.yaml > srcs/metalLB.yaml
	sed -i "s|IP2|${baseip}.160|" srcs/metalLB.yaml
	echo -e "${EREASE}✅ Setup IPs done !"
	echo "⌛ Applying srcs/metalLB.yaml"
	kubectl apply -f srcs/metalLB.yaml 																					&>> logs/minikube.log
	echo -e "${EREASE}✅ Setup srcs/metalLB.yaml done !"
}
