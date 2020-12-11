#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    docker_build.sh                                    :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/08 12:09:03 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 14:38:29 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


function build_image()
{
	echo -e "${C_CYAN}Build Images${C_RESET}"
	find -type f -name "Dockerfile" -print0 |
	while IFS= read -r -d '' file; do
		image="$(echo ${file} | awk -F/ '{print $3}')-image"
		dir=$(dirname ${file})
		touch logs/${image}.log
		echo "⌛ Building ${image}"
		docker build -t ${image} ${dir} > logs/${image}.log
		echo -e "${EREASE}✅ Build ${image} done !"
	done
}
