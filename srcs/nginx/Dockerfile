# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/01 15:20:11 by atrouill          #+#    #+#              #
#    Updated: 2020/12/04 13:53:40 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM	alpine

RUN 	apk add nginx openrc openssl

RUN		mkdir /run/nginx /www && \
		chown -R nginx:nginx /www && \
	 	openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 \
		 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

ADD		srcs/nginx.conf /etc/nginx/
ADD		srcs/index.html	/www/
ADD		srcs/launch.sh .

EXPOSE	80 443

CMD		[ "/bin/ash", "launch.sh" ]
