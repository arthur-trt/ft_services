# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    livenessprobe.sh                                   :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/26 18:04:11 by atrouill          #+#    #+#              #
#    Updated: 2020/12/26 18:05:46 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if ! nc -z 127.0.0.1 22 &> /dev/null; then
	echo "Can't bind ssh server"
	exit 1
fi

if ! wget --no-check-certificate -t 1 --timeout=2 -qO- https://localhost/ &> /dev/null; then
	echo "Can't connect to nginx"
	exit 1
fi
