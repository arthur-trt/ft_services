#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    apply_yaml.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 14:22:05 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 14:22:06 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


function apply_secret()
{
	echo -e "${C_CYAN}Applying Secret${C_RESET}"
	find -type f -name "*secret*.yaml" -print0 |
	while IFS= read -r -d '' file; do
		echo "⌛ Applying ${file}"
		if ! (kubectl apply -f "${file}"	>> logs/minikube.log); then
			echo "❌ Problem when applying ${file}"
			exit 1
		fi
		echo -e "${EREASE}✅ Applying ${file} done !"
	done
}


function apply_rbac()
{
	echo -e "${C_CYAN}Applying RBAC${C_RESET}"
	find -type f -name "*-rbac.yaml" -print0 |
	while IFS= read -r -d '' file; do
		echo "⌛ Applying ${file}"
		if ! (kubectl apply -f "${file}"	>> logs/minikube.log); then
			echo "❌ Problem when applying ${file}"
			exit 1
		fi
		echo -e "${EREASE}✅ Setup ${file} done !"
	done
}

function apply_pvc()
{
	echo -e "${C_CYAN}Applying PVC${C_RESET}"
	find -type f -name "*-pvc.yaml" -print0 |
	while IFS= read -r -d '' file; do
		echo "⌛ Applying ${file}"
		if ! (kubectl apply -f "${file}"	>> logs/minikube.log); then
			echo "❌ Problem when applying ${file}"
			exit 1
		fi
		echo -e "${EREASE}✅ Setup ${file} done !"
	done
}


function apply_svc()
{
	echo -e "${C_CYAN}Applying SVC${C_RESET}"
	find -type f -name "*-svc.yaml" -print0 |
	while IFS= read -r -d '' file; do
		echo "⌛ Applying ${file}"
		if ! (kubectl apply -f "${file}"	>> logs/minikube.log); then
			echo "❌ Problem when applying ${file}"
			exit 1
		fi
		echo -e "${EREASE}✅ Setup ${file} done !"
	done
}

function apply_app()
{
	echo -e "${C_CYAN}Applying App${C_RESET}"
	find -mindepth 3 -maxdepth 3 -type f -name "*.yaml" ! -name "*-*" -print0 |
	while IFS= read -r -d '' file; do
		echo "⌛ Applying ${file}"
		if ! (kubectl apply -f "${file}"	>> logs/minikube.log); then
			echo "❌ Problem when applying ${file}"
			exit 1
		fi
		echo -e "${EREASE}✅ Setup ${file} done !"
	done
}
