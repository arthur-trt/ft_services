# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/04 13:59:28 by atrouill          #+#    #+#              #
#    Updated: 2020/12/11 12:42:04 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

RUN	apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community telegraf

ADD srcs/launch.sh .
ADD srcs/telegraf.conf /etc/telegraf.conf

EXPOSE 8125 8080

CMD [ "/bin/ash", "launch.sh" ]
