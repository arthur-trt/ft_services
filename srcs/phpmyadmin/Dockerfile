# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/03 16:04:07 by atrouill          #+#    #+#              #
#    Updated: 2020/12/04 13:53:50 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

RUN apk add wget tar nginx openssl openrc php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ctype php7-dom php7-fpm php7-session php7-mbstring

ADD srcs/launch.sh .
ADD srcs/nginx.conf /etc/nginx/nginx.conf

RUN	mkdir /run/nginx /www && \
		chown -R nginx:nginx /www && \
	 	openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 \
		 -keyout /etc/ssl/private/server.key -out /etc/ssl/certs/server.crt

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-english.tar.gz
RUN	tar xzf phpMyAdmin-5.0.4-english.tar.gz -C /www/
RUN	mv /www/phpMyAdmin-5.0.4-english /www/phpmyadmin
RUN	sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$(openssl rand -base64 32)'|" /www/phpmyadmin/config.sample.inc.php > /www/phpmyadmin/config.inc.php
RUN	sed -i "s|i\]\['host'\] = 'localhost';|i]['host'] = 'mysql-svc.default.svc.cluster.local';|" /www/phpmyadmin/config.inc.php
RUN mkdir /www/phpmyadmin/tmp && chmod 777 /www/phpmyadmin/tmp

EXPOSE 5000

CMD [ "/bin/ash", "launch.sh" ]
