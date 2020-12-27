#!/bin/ash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    livenessprobe.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/14 15:30:01 by atrouill          #+#    #+#              #
#    Updated: 2020/12/14 15:30:02 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if ! cgi-fcgi -bind -connect localhost:9000 &> /dev/null; then
	echo "Can't bind php-fpm"
	exit 1
fi

if ! wget --no-check-certificate -t 1 --timeout=2 -qO- https://localhost:5050/license.txt &> /dev/null; then
	echo "Can't connect to nginx"
	exit 1
fi

exit 0
