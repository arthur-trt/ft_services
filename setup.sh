#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 15:32:02 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 15:32:03 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#
# Stop on error
#
set -e

#
# IMPORT
#
source srcs/setup/color.sh
source srcs/setup/kubernetes.sh
source srcs/setup/apply_yaml.sh
source srcs/setup/secret_gen.sh
source srcs/setup/docker_build.sh
source srcs/setup/show_infos.sh
source srcs/setup/utils.sh

#
# Check if user want to clean
#
if [[ $1 == "clean" ]]; then
	clean
	minikube delete
	exit 0
fi

#
# Launch clean if directory logs exists
#
if [[ -d "logs/" ]]; then
	clean
fi

mkdir -p logs/
start_minikube
configure_metalLB

if [[ $1 == "--mkcert" ]]; then
	install_mkcert
	configure_mkcert
fi

apply_pvc
apply_rbac
apply_svc
build_image
build_secret
apply_secret
apply_app
show_infos
