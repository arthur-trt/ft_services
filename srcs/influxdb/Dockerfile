# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/04 09:44:38 by atrouill          #+#    #+#              #
#    Updated: 2020/12/06 16:44:42 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

ADD srcs/launch.sh .

RUN apk add openrc influxdb

EXPOSE 8086 8083

CMD [ "/bin/ash", "launch.sh" ]
