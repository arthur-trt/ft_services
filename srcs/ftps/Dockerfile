# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/07 22:30:17 by atrouill          #+#    #+#              #
#    Updated: 2020/12/08 14:06:13 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

RUN apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community  proftpd proftpd-mod_tls openssl

RUN mkdir /run/proftpd/

RUN sed -i "s|#DefaultRoot ~|DefaultRoot ~|" /etc/proftpd/proftpd.conf 								&& \
	sed -i "s|ProFTPD Default Installation|ft_services FTPs Server !|" /etc/proftpd/proftpd.conf	&& \
	echo "PassivePorts 60000 60010" >> /etc/proftpd/proftpd.conf									&& \
	echo "SystemLog /var/log/proftpd.log" >> /etc/proftpd/proftpd.conf								&& \
	echo "TransferLog /var/log/xferlog" >> /etc/proftpd/proftpd.conf								&& \
	touch /var/log/xferlog																			&& \
	mkdir /etc/proftpd/ssl																			&& \
	openssl req -x509 -nodes -subj '/CN=localhost' -days 365 -newkey rsa:4096 						\
	-keyout /etc/proftpd/ssl/proftpd-key.pem -out /etc/proftpd/ssl/proftpd-rsa.pem					&& \
	chmod 440 /etc/proftpd/ssl/proftpd-key.pem

ADD srcs/launch.sh .
ADD srcs/tls.conf /etc/proftpd/conf.d/.

EXPOSE 21 20

CMD [ "/bin/ash", "launch.sh" ]
