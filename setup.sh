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

source srcs/setup/color.sh
source srcs/setup/kubernetes.sh
source srcs/setup/apply_yaml.sh
source srcs/setup/secret_gen.sh
source srcs/setup/docker_build.sh
source srcs/setup/show_infos.sh


mkdir -p logs/
rm -rf logs/*

minikube start --vm-driver=docker		> logs/minikube.log
eval $(minikube docker-env)
start_minikube
configure_metalLB
apply_pvc
apply_rbac
apply_svc
build_image
build_secret
apply_secret
apply_app
show_infos
