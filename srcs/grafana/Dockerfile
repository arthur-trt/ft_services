# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: atrouill <atrouill@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/12/04 16:11:10 by atrouill          #+#    #+#              #
#    Updated: 2020/12/09 15:42:05 by atrouill         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine

ADD srcs/launch.sh .

# Fix libc dependency to run the grafana binary
RUN		mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

# --- Grafana Installation
# Download
RUN		cd /tmp \
		&& wget -q https://dl.grafana.com/oss/release/grafana-7.3.4.linux-amd64.tar.gz \
		&& tar -zxvf grafana-7.3.4.linux-amd64.tar.gz \
		&& mv grafana-7.3.4 grafana \
		&& mv grafana /root \
		&& apk add curl

# Installation
RUN		ln -s /root/grafana/bin/grafana-cli /usr/bin \
		&& ln -s /root/grafana/bin/grafana-server /usr/bin

ADD srcs/datasources.yaml /root/grafana/conf/provisioning/datasources/.
ADD srcs/dashboard.yaml /root/grafana/conf/provisioning/dashboards/.
ADD srcs/dashboard.json /root/grafana/conf/provisioning/dashboards/.

EXPOSE 3000

CMD [ "/bin/ash", "launch.sh" ]
