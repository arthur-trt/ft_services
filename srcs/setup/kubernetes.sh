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
#	minikube start --vm-driver=docker		> logs/minikube.log
	eval $(minikube docker-env)				>> logs/minikube.log
#	echo -e "${EREASE}✅ Minikube started !"
	echo "⌛ Enable metrics-server"
	minikube addons enable metrics-server	>> logs/minikube.log
	echo -e "${EREASE}✅ Metrics-server configured !"
	echo "⌛ Enable dashboard"
	minikube addons enable dashboard		>> logs/minikube.log
	echo -e "${EREASE}✅ Dashboard configured !"
	eval $(minikube docker-env)				>> logs/minikube.log
}


function configure_metalLB()
{
	echo -e "${C_CYAN}Configure MetalLB${C_RESET}"
	echo "⌛ Download configuration"
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml					>> logs/minikube.log
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml					>> logs/minikube.log
	echo -e "${EREASE}✅ Configuration downloaded !"
	echo "⌛ Create secret"
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"	>> logs/minikube.log
	echo -e "${EREASE}✅ Setup secret done !"
	echo "⌛ Applying srcs/metalLB.yaml"
	kubectl apply -f srcs/metalLB.yaml 																					>> logs/minikube.log
	echo -e "${EREASE}✅ Setup srcs/metalLB.yaml done !"
}
