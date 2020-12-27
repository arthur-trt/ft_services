# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 15:18:42 by atrouill          #+#    #+#              #
#    Updated: 2020/12/14 13:21:06 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM 	alpine

RUN 	apk add wget nginx openssl openrc php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-fpm mysql-client

ADD		srcs/nginx.conf	/etc/nginx/
ADD		srcs/. .

RUN		mkdir /run/nginx /www && \
		chown -R nginx:nginx /www && \
	 	openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 \
		 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

RUN 	wget -q https://wordpress.org/latest.tar.gz && \
		tar xzf latest.tar.gz -C /www/

ADD		srcs/wp-config.php /www/wordpress/.

EXPOSE	5050

CMD		[ "/bin/ash", "/launch.sh" ]
