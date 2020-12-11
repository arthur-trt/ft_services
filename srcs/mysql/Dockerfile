# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/02 10:46:48 by atrouill          #+#    #+#              #
#    Updated: 2020/12/04 09:33:32 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

RUN apk add mysql mysql-client openrc

ADD srcs/launch.sh .

RUN sed -i "s|skip-networking|skip-networking=false|" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

CMD [ "/bin/ash", "launch.sh" ]
